help:
clean:
	rm -rf target *.deb *.sha256sum *.sha512sum *.rpm ~/rpmbuild
shellcheck:
	./scripts/shellcheck.sh
build-deb: clean shellcheck
	./scripts/build-deb.sh
build-rpm: clean shellcheck
	scripts/build-rpms.sh
set-version:
	scripts/set-version.sh
commit:
	scripts/git-commit-and-push.sh
release:
	scripts/create-release.sh
all-deb: clean set-version build-deb
all-rpm: clean set-version build-rpm

deb-install:
	apt install ./*.deb
deb-uninstall:
	apt remove siakhooi-ele
rpm-install:
	rpm -i ./*.rpm
rpm-uninstall:
	rpm -e siakhooi-ele
