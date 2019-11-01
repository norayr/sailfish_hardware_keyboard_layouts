#
# spec file for Armenian layout
#
Summary: Armenian, Programmers Dvorak, Georgian, Russian phonetic hardware keyboard layouts
Name: keyboard-hw-inky
Version: 1.0
Release: 1
License: GPL
Group: Applications/System
BuildArch: noarch
Source: http://norayr.am/works/keyboard-hw-inky.tar.gz
URL: https://github.com/norayr
#Distribution: WSS Linux
Requires: armenian-fonts patch
Vendor: Norayr Chilingarian.
Packager: Norayr Chilingarian <norayr@arnet.am>

%description
Armenian, Programmers Dvorak, Georgian and Russian phonetic hardware keyboard layouts for Sailfish

%prep
rm -rf $RPM_BUILD_DIR/keyboard-hw-inky
zcat $RPM_SOURCE_DIR/keyboard-hw-inky.tar.gz | tar -xvf -

%build
#make

%install
cd %{name}
make install

%post
cd /usr/share/qt5/keymaps
if [ -f boston.qmap ]; then
 mv boston.qmap boston.qmap.orig
 cp inky.qmap boston.qmap
fi
if [ -f droid.qmap ]; then
 mv droid.qmap droid.qmap.orig
 cp inky.qmap droid.qmap
fi
cd /usr/share/jolla-settings/pages/text_input/
cp textinput.qml textinput.qml.orig
patch -R textinput.qml < inky.patch

%postun
cd /usr/share/qt5/keymaps
if [ -f boston.qmap ]; then
 cp boston.qmap.orig boston.qmap
fi
if [ -f droid.qmap ]; then
 cp droid.qmap.orig droid.qmap
fi
cd /usr/share/jolla-settings/pages/text_input/
mv textinput.qml.orig textinput.qml

%files
#/usr/share/qt5/keymaps/inky.qmap
#/usr/share/jolla-settings/pages/text_input/inky.patch

