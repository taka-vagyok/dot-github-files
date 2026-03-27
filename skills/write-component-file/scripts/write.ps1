param (
    [Parameter(Mandatory=$true)]
    [string]$Filepath,

    [Parameter(Mandatory=$true)]
    [string]$ContentString
)

# パスのチェック
if ([string]::IsNullOrWhiteSpace($Filepath)) {
    Write-Error "[ERROR] Filepath cannot be empty."
    exit 1
}

try {
    # 親ディレクトリの取得と作成
    $parentDir = Split-Path -Path $Filepath -Parent
    if (-not [string]::IsNullOrWhiteSpace($parentDir) -and -not (Test-Path -Path $parentDir)) {
        New-Item -ItemType Directory -Force -Path $parentDir | Out-Null
    }

    # ファイルへの書き込み（UTF-8 BOMなし）
    [System.IO.File]::WriteAllText($Filepath, $ContentString, [System.Text.Encoding]::UTF8)

    Write-Host "[SUCCESS] Wrote to $Filepath"
}
catch {
    Write-Error "[ERROR] Failed to write to file: $Filepath. Details: $_"
    exit 1
}
