# ============================================================
#  AdventureWorks - setup do banco para o trabalho pratico
#
#  COMO RODAR (uma vez):
#    1. Clique com o botao direito neste arquivo
#    2. Escolha "Executar com o PowerShell"
#       (se pedir UAC, confirme)
#
#  O que ele faz:
#    1. Instala o SQL Server LocalDB 2022 (se nao estiver)
#    2. Restaura o backup AdventureWorks2025.bak
#    3. Exporta TODAS as tabelas para CSV em  F:\Evidence-main\data-aw
#
#  Depois disso: abra o Power BI Desktop -> Obter Dados -> Texto/CSV
#  e importe os arquivos de F:\Evidence-main\data-aw
# ============================================================
$ErrorActionPreference = "Stop"

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent().Identity).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERRO: rode este script como ADMINISTRADOR (botao direito -> Executar com o PowerShell)." -ForegroundColor Red
    exit 1
}

# --- 1. LocalDB -------------------------------------------------
$binn = "$env:ProgramFiles(x86)\Microsoft SQL Server\170\Tools\Binn"
$sqlcmd = "$binn\SQLCMD.EXE"
$bcp    = "$binn\bcp.exe"
if (-not (Test-Path $sqlcmd)) {
    Write-Host "Instalando SQL Server LocalDB 2022 (winget)... pode demorar" -ForegroundColor Cyan
    winget install --id Microsoft.SQLServer.2022.LocalDB -e --accept-source-agreements --accept-package-agreements
    if (-not (Test-Path $sqlcmd)) {
        Write-Host "ERRO: SQLCMD nao encontrado apos a instalacao. Rode 'winget list' e veja o log." -ForegroundColor Red
        exit 1
    }
}
Write-Host "SQLCMD: $sqlcmd" -ForegroundColor Green

# --- 2. Localiza o .bak -----------------------------------------
$candidates = @("$env:USERPROFILE\AdventureWorks2025.bak", "F:\AdventureWorks2025.bak")
$bak = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $bak) { Write-Host "ERRO: AdventureWorks2025.bak nao encontrado." -ForegroundColor Red; exit 1 }
Write-Host "Backup: $bak" -ForegroundColor Green

$localdbRoot = "$env:ProgramFiles(x86)\Microsoft SQL Server\LocalDB"
$inst = Get-ChildItem $localdbRoot -Directory -ErrorAction SilentlyContinue |
        Where-Object { Test-Path "$($_.FullName)\mssqlsystemresource.mdf" } | Select-Object -First 1
if (-not $inst) {
    $inst = Get-ChildItem $localdbRoot -Directory | Where-Object Name -match '^\d+\.' | Select-Object -First 1
}
if (-not $inst) { Write-Host "ERRO: instancia LocalDB nao encontrada em $localdbRoot" -ForegroundColor Red; exit 1 }
$srv = "localhost\$($inst.Name)\sqldbat$($inst.Name)"
Write-Host "Instancia: $srv" -ForegroundColor Green

# --- 3. Restaura o banco ----------------------------------------
$restoreSql = @"
USE master;
GO
IF DB_ID('AdventureWorks2025') IS NOT NULL
BEGIN
    ALTER DATABASE [AdventureWorks2025] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [AdventureWorks2025];
END;
GO
RESTORE DATABASE [AdventureWorks2025] FROM DISK = N'$bak' WITH REPLACE,
    MOVE N'AdventureWorks2025'     TO N'$($inst.FullName)\AdventureWorks2025.mdf',
    MOVE N'AdventureWorks2025_log' TO N'$($inst.FullName)\AdventureWorks2025_log.ldf';
GO
"@
$restoreSql | Out-File -Encoding utf8 "$env:TEMP\aw_restore.sql"
Write-Host "Restaurando o banco (pode levar alguns minutos)..." -ForegroundColor Cyan
& $sqlcmd -S $srv -E -i "$env:TEMP\aw_restore.sql"
if ($LASTEXITCODE -ne 0) {
    # tenta descobrir os nomes reais dos arquivos do backup
    Write-Host "Restauracao falhou com nomes padrao. Listando arquivos do backup..." -ForegroundColor Yellow
    & $sqlcmd -S $srv -E -Q "RESTORE FILELISTONLY FROM DISK = N'$bak'"
    Write-Host "Ajuste os MOVE do script e rode de novo." -ForegroundColor Red
    exit 1
}
Write-Host "Banco restaurado com sucesso." -ForegroundColor Green

# --- 4. Exporta as tabelas para CSV ------------------------------
$out = "F:\Evidence-main\data-aw"
New-Item -ItemType Directory -Force -Path $out | Out-Null

$tables = & $sqlcmd -S $srv -d AdventureWorks2025 -E -W -s "|" -Q "SELECT SCHEMA_NAME(schema_id) + '.' + name FROM sys.tables WHERE schema_id = SCHEMA_ID('dbo') ORDER BY name"
$tables = $tables | Where-Object { $_ -match '^[A-Za-z]' }

Write-Host "Exportando $($tables.Count) tabelas para $out ..." -ForegroundColor Cyan
foreach ($t in $tables) {
    $file = "$out\$($t.Replace('.', '_')).csv"
    & $bcp "SELECT * FROM [$t]" queryout $file -S $srv -d AdventureWorks2025 -T -c -t"," -r"\n"
    if ($LASTEXITCODE -ne 0) { Write-Host "  FALHOU: $t" -ForegroundColor Red }
    else { Write-Host "  ok: $t" -ForegroundColor DarkGray }
}

$csvs = Get-ChildItem "$out\*.csv"
Write-Host ""
Write-Host "PRONTO! $($csvs.Count) CSVs em $out" -ForegroundColor Green
Write-Host ""
Write-Host "Proximo passo: Power BI Desktop -> Obter Dados -> Texto/CSV -> $out"
