This is a repackaging of [rsync (from msys2)](https://github.com/Alexpux/MSYS2-packages/blob/master/rsync) for use in vagrant base images.

This is used in my [rgl/windows-vagrant base images](https://github.com/rgl/windows-vagrant) and tested in [rgl/openssh-server-windows-vagrant](https://github.com/rgl/openssh-server-windows-vagrant).

# Build (in a Ubuntu host)

Install the [windows-2022-uefi-amd64 vagrant box](https://github.com/rgl/windows-vagrant).

Build the `rsync-vagrant-<version>-<date>.zip` file:

```bash
vagrant up --no-destroy-on-error --provider=libvirt
ls -laF rsync-vagrant-*.zip
vagrant destroy -f
```

# Usage (in a Windows host)

Download a release, e.g.:

```powershell
# see https://github.com/rgl/rsync-vagrant/releases
$version = "3.4.1-20250411"
$url = "https://github.com/rgl/rsync-vagrant/releases/download/v$version/rsync-vagrant-$version.zip"
$d = "$PWD\tmp\rsync"
$z = "$d\rsync.zip"
if (Test-Path $d) {
    Remove-Item -Recurse $d
}
mkdir "$d" | Out-Null
(New-Object Net.WebClient).DownloadFile($url, $z)
Expand-Archive `
    -Path $z `
    -DestinationPath $d
```

In Windows PowerShell, you can synchronize two local directories as, e.g.:

**NB** You cannot use a path with a Windows drive letter, e.g., instead of `c:\` use `/cygdrive/c/`.

```powershell
&"$d/rsync.exe" `
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
```
