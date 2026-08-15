Name:           siakhooi-ele
Version:        0.5.0
Release:        1%{?dist}
Summary:        docker compose cluster for local developments

License:        MIT
URL:            https://github.com/siakhooi/ele
Source0:        https://github.com/siakhooi/%{name}/archive/refs/tags/${version}.tar.gz
BuildArch:      noarch

Requires:       bash

%description
docker compose cluster for local developments.

%install
%{__mkdir}   -v -p %{buildroot}%{_bindir}
%{__mkdir}   -v -p %{buildroot}%{_libdir}/ele
%{__mkdir}   -v -p %{buildroot}/usr/share/licenses/siakhooi-ele
%{__install} -v -m 0755 %{_topdir}/BUILD/usr/bin/* %{buildroot}%{_bindir}
%{__install} -v -m 0755 %{_topdir}/BUILD/usr/lib/ele/* %{buildroot}%{_libdir}/ele
%{__install} -v -m 644  %{_topdir}/BUILD/LICENSE %{buildroot}/usr/share/licenses/siakhooi-ele

%files
%license LICENSE
%{_bindir}/ele-completion
%{_bindir}/ele-config
%{_bindir}/ele-config-set
%{_bindir}/ele-down
%{_bindir}/ele-init
%{_bindir}/ele-logs
%{_bindir}/ele-ps
%{_bindir}/ele-setup
%{_bindir}/ele-stats
%{_bindir}/ele-up
%{_libdir}/ele/list-compose-init.sh
%{_libdir}/ele/list-compose-running.sh
%{_libdir}/ele/list-compose.sh
%{_libdir}/ele/list-script-execution.sh
%{_libdir}/ele/list-script-setup.sh
%{_libdir}/ele/get-path-compose-init.sh
%{_libdir}/ele/get-path-compose.sh
%{_libdir}/ele/get-path-script-exec.sh
%{_libdir}/ele/get-path-script-setup.sh


%changelog
* Sat Aug 15 2026 Siak Hooi <siakhooi@gmail.com> - 0.5.0
- bin add: ele-up
- bin add: ele-down

* Wed Jul 29 2026 Siak Hooi <siakhooi@gmail.com> - 0.4.0
- lib add: get-path-compose-init.sh
- lib add: get-path-compose.sh
- lib add: get-path-script-exec.sh
- lib add: get-path-script-setup.sh

* Fri Jul 24 2026 Siak Hooi <siakhooi@gmail.com> - 0.3.0
- bin change: combine ele-config and ele-config-edit
- bin add: ele-ps
- bin add: ele-stats
- lib add: list-compose-init.sh
- lib add: list-compose-running.sh
- lib add: list-compose.sh
- lib add: list-script-execution.sh
- lib add: list-script-setup.sh

* Tue Apr 7 2026 Siak Hooi <siakhooi@gmail.com> - 0.2.0
- ele-config -h
- ele-config-edit -h

* Wed Nov 12 2025 Siak Hooi <siakhooi@gmail.com> - 0.1.1
- fix release bugs

* Wed Nov 12 2025 Siak Hooi <siakhooi@gmail.com> - 0.1.0
- initial version
