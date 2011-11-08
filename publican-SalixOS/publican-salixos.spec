%define brand SalixOS

Name:		publican-salixos
Summary:	Common documentation files for %{brand}
Version:	0.1
Release:	0%{?dist}
License:	CC BY-SA 3.0
Group:		Applications/Text
Buildroot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Buildarch:	noarch
Source:		http://www.salixos.org/source/%{name}-%{version}.tgz
Requires:	publican >= 1.99
BuildRequires:	publican >= 1.99
URL:		http://www.salixos.org

%description
This package provides common files and templates needed to build documentation
for %{brand} with publican.

%prep
%setup -q 

%build
publican build --formats=xml --langs=all --publish

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p -m755 $RPM_BUILD_ROOT%{_datadir}/publican/Common_Content
publican install_brand --path=$RPM_BUILD_ROOT%{_datadir}/publican/Common_Content

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%doc README
%doc COPYING
%{_datadir}/publican/Common_Content/%{brand}

%changelog
* Fri Nov  4 2011  SETUP:YourName <SETUP:your.email@example.com> 0.1
- Created Brand

