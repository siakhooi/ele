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

root := justfile_directory()
docker-test:
	docker run --rm -v {{ root }}:/workspaces docker.io/siakhooi/devcontainer:deb2604 scripts/bats-test.sh

docker-build-rpm:
	docker run --rm -v {{ root }}:/workspaces docker.io/siakhooi/devcontainer:rpm44 scripts/build-rpms.sh
docker-build-deb:
	docker run --rm -v {{ root }}:/workspaces docker.io/siakhooi/devcontainer:deb2604 scripts/build-deb.sh

all: clean set-version shellcheck docker-build-deb docker-build-rpm
