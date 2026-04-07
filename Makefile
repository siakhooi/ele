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
docker-build-rpm:
	docker run --rm -v $(CURDIR):/workspaces docker.io/siakhooi/devcontainer:rpm scripts/build-rpms.sh
docker-build-deb:
	docker run --rm -v $(CURDIR):/workspaces docker.io/siakhooi/devcontainer:deb scripts/build-deb.sh