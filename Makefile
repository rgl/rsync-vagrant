RSYNC_VERSION=$(shell rsync --version | awk '/version/{print $$3}')
RSYNC_DEPENDENCIES=$(shell ldd /bin/rsync | awk '/msys-/{print $$1}')

all: rsync-vagrant-$(RSYNC_VERSION).zip

clean:
	rm -f rsync-*.zip

rsync-vagrant-$(RSYNC_VERSION).zip:
	cd /bin && zip -9 $(PWD)/$@ rsync.exe $(RSYNC_DEPENDENCIES)
	unzip -l $@
	sha256sum $@

.PHONY: all clean
