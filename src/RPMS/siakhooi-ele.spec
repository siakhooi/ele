Name:           siakhooi-ele
Version:        0.1.1
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
%{__mkdir}   -v -p %{buildroot}/usr/share/licenses/siakhooi-ele
%{__install} -v -m 0755 %{_topdir}/BUILD/usr/bin/* %{buildroot}%{_bindir}
%{__install} -v -m 644  %{_topdir}/BUILD/LICENSE %{buildroot}/usr/share/licenses/siakhooi-ele

%files
%license LICENSE
%{_bindir}/ele-config
%{_bindir}/ele-config-edit
%{_bindir}/ele-config-set

%changelog
* Wed Nov 12 2025 Siak Hooi <siakhooi@gmail.com> - 0.1.1
- fix release bugs

* Wed Nov 12 2025 Siak Hooi <siakhooi@gmail.com> - 0.1.0
- initial version
