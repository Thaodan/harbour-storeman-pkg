# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       harbour-storeman

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    OpenRepos Client for Sailfish OS
Version:    0.0.15
Release:    2
Group:      Qt/Qt
License:    LICENSE
URL:        https://github.com/mentaljam/harbour-storeman
Source: %{name}-%{version}.tar.gz
Requires:   sailfishsilica-qt5 >= 0.10.9
Requires:   PackageKit >= 0.8.9
Requires:   PackageKit-Qt5 >= 0.8.8
Requires:   libsolv0
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Concurrent)
BuildRequires:  pkgconfig(packagekit-qt5) >= 0.8.8
BuildRequires:  libsolv-devel
BuildRequires:  desktop-file-utils

%description
Unofficial native OpenRepos.net client for Sailfish OS


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre
cd %{name}
%qtc_qmake5  \
    VERSION=%{version} \


%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
%{_sharedstatedir}/polkit-1/localauthority/50-local.d/50-harbour-storeman-packagekit.pkla
%{_datadir}/dbus-1/services/harbour.storeman.service
# >> files
# << files
