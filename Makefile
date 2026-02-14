DATE=$(shell date +%Y%m%d)
RSYNC_VERSION=$(shell rsync --version | awk '/version/{print $$3}')
RSYNC_DEPENDENCIES=$(shell ldd /bin/rsync | awk '/msys-/{print $$1}')
RSYNC_ARCHIVE=rsync-vagrant-$(RSYNC_VERSION)-$(DATE).zip

all: $(RSYNC_ARCHIVE)

clean:
	rm -f $(RSYNC_ARCHIVE)

$(RSYNC_ARCHIVE):
	rm -rf build
	install -d \
		build/cmd \
		build/bin
	cd build/cmd \
		&& wget https://github.com/kiennq/scoop-better-shimexe/releases/download/v3.2.1/shimexe-x86_64.zip \
		&& unzip shimexe-x86_64.zip shim.exe \
		&& mv shim.exe rsync.exe \
		&& rm shimexe-x86_64.zip \
		&& printf "path = \"C:\\\\Program Files\\\\rsync\\\\bin\\\\rsync.exe\"\n" >rsync.shim
	cd /bin \
		&& cp -a rsync.exe $(RSYNC_DEPENDENCIES) $(PWD)/build/bin
	cd build \
		&& zip -r -9 $(PWD)/$@ *
	unzip -l $@
	sha256sum $@

.PHONY: all clean
