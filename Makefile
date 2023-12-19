DATE=$(shell date +%Y%m%d)
RSYNC_VERSION=$(shell rsync --version | awk '/version/{print $$3}')
RSYNC_DEPENDENCIES=$(shell ldd /bin/rsync | awk '/msys-/{print $$1}')
RSYNC_ARCHIVE=rsync-vagrant-$(RSYNC_VERSION)-$(DATE).zip

all: $(RSYNC_ARCHIVE)

clean:
	rm -f $(RSYNC_ARCHIVE)

$(RSYNC_ARCHIVE):
	cd /bin && zip -9 $(PWD)/$@ rsync.exe $(RSYNC_DEPENDENCIES)
	unzip -l $@
	sha256sum $@

.PHONY: all clean
