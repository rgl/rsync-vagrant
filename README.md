This is a repackaging of [rsync (from msys2)](https://github.com/Alexpux/MSYS2-packages/blob/master/rsync) for use in vagrant base images.

This is used in my [windows vagrant base images](https://github.com/rgl/windows-vagrant).

# Usage

Install the [windows-2022-amd64 vagrant box](https://github.com/rgl/windows-vagrant).

Build the `rsync-vagrant-<version>-<date>.zip` file:

```bash
vagrant up --no-destroy-on-error --provider=libvirt
vagrant destroy -f
```
