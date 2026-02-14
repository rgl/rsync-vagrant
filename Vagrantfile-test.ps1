Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Output "ERROR: $_"
    Write-Output (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
    Write-Output (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
    Exit 1
}

# install.
$z = Resolve-Path "C:\vagrant\rsync-vagrant-*-$(Get-Date -Format yyyyMMdd).zip"
$d = "c:\tmp\rsync"
if (Test-Path $d) {
    Remove-Item -Recurse $d
}
mkdir $d | Out-Null
Expand-Archive `
    -Path $z `
    -DestinationPath $d

# add to path.
$env:PATH = "$d;C:\Windows\system32;C:\Windows"

# test.
if (Test-Path C:\tmp\test) {
    Remove-Item -Recurse -Force C:\tmp\test
}
mkdir C:\tmp\test | Out-Null
1..3 | ForEach-Object {
    Write-Host "Running rsync #$_..."
    rsync.exe `
        --verbose `
        --archive `
        --delete `
        --compress `
        --copy-links `
        --no-owner `
        --no-group `
        --exclude .vagrant/ `
        --exclude .git/ `
        --exclude *.box `
        /cygdrive/c/vagrant/ `
        /cygdrive/c/tmp/test/
    if ($LASTEXITCODE) {
        throw "rsync failed with exit code $LASTEXITCODE"
    }
}
(Get-ChildItem -Path c:/tmp/test -Recurse -File).FullName | Sort-Object
