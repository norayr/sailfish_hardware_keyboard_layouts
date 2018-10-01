

Introduction
============

This can be viewed as a guide on how to prepare custom hardware keyboard layouts for Qt mobile devices, like Jolla Sailfish.

In order to use custom layouts with Sailfish, it is necessary to generate a qmapfile.

For this we need to:

The flow
========


Tools: 
* ckbcomp - to convert xkb layout to kmap file. to be precise create one kmap file for each variant of the layout.
* kmap2qmap - to convert kmap files to qmap file


To install on device:

* replace qmap file on a device
* add necessary layouts to the sailfish menu

Get the tools - ckbcomp
=======================

On my system ckbcomp - utility that converts xkb layouts to kmap files, can be installed as follows:

```
emerge ckbcomp
```

Convert xkb layouts to kmap files
=================================

At this step you can create kmap files for your favourite layouts.

In my case those are us(dvp), am.
dvp variant of us layout is programmer's dvorak.
default layout in am xkb file is typewriter.

```
ckbcomp -keycodes evdev -layout us -variant dvp > /tmp/usdvp.kmap
ckbcomp -keycodes evdev -layout am > /tmp/am.kmap
ckbcomp -keycodes evdev -layout ge > /tmp/ge.kmap
```

Get kmap2qmap
=============

Apparently kmap2qmap is absent in all linux distributions.
So, my qt version on my laptop is 5.9.4, so i went to qt site, and downloaded version of qttools source for that version.

```
https://download.qt.io/archive/qt/5.9/5.9.4/submodules/qttools-opensource-src-5.9.4.tar.xz
```

unpack:

```
tar Jxvf qttools-opensource-src-5.9.4.tar.xz
```

compile:

```
cd src/kmap2qmap/

```

To compile, type ```qmake``` and then ```make```:

```
noch@aygepar /tmp/qttools-opensource-src-5.9.4/src/kmap2qmap $ qmake
Info: creating stash file /tmp/qttools-opensource-src-5.9.4/.qmake.stash
noch@aygepar /tmp/qttools-opensource-src-5.9.4/src/kmap2qmap $ ls
kmap2qmap.pro  main.cpp  Makefile  target_wrapper.sh
noch@aygepar /tmp/qttools-opensource-src-5.9.4/src/kmap2qmap $ make
x86_64-pc-linux-gnu-g++ -c -O2 -march=native -pipe -std=c++1z -fno-exceptions -Wall -W -Wvla -Wdate-time -Wshift-overflow=2 -Wduplicated-cond -D_REENTRANT -fPIC -DQT_NO_NARROWING_CONVERSIONS_IN_CONNECT -DQT_NO_EXCEPTIONS -D_LARGEFILE64_SOURCE -D_LARGEFILE_SOURCE -DQT_NO_DEBUG -DQT_INPUT_SUPPORT_LIB -DQT_DEVICEDISCOVERY_SUPPORT_LIB -DQT_GUI_LIB -DQT_CORE_LIB -I. -isystem /usr/include/qt5 -isystem /usr/include/qt5/QtInputSupport -isystem /usr/include/qt5/QtInputSupport/5.9.4 -isystem /usr/include/qt5/QtInputSupport/5.9.4/QtInputSupport -isystem /usr/include/qt5/QtGui/5.9.4 -isystem /usr/include/qt5/QtGui/5.9.4/QtGui -isystem /usr/include/qt5/QtDeviceDiscoverySupport -isystem /usr/include/qt5/QtDeviceDiscoverySupport/5.9.4 -isystem /usr/include/qt5/QtDeviceDiscoverySupport/5.9.4/QtDeviceDiscoverySupport -isystem /usr/include/qt5/QtCore/5.9.4 -isystem /usr/include/qt5/QtCore/5.9.4/QtCore -isystem /usr/include/qt5/QtGui -isystem /usr/include/qt5/QtCore -I.moc -isystem /usr/include/libdrm -I/usr/lib64/qt5/mkspecs/linux-g++ -o .obj/main.o main.cpp
x86_64-pc-linux-gnu-g++ -Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,--gc-sections -Wl,--enable-new-dtags -o ../../bin/kmap2qmap .obj/main.o   -lQt5InputSupport -lmtdev -linput -lxkbcommon -lQt5DeviceDiscoverySupport -ludev -lQt5Gui -lQt5Core -lGL -lpthread
```


Find the compiled binary at ```../../bin/``` directory.

You can install it to your ~/bin directory.

```
cp ../../bin/kmap2qmap ~/bin
```

if you use one.

Get additional Jolla specific kmap files
========================================

Otherwise volume keys won't work.

One way to get those is from ```https://github.com/mer-hybris/droid-hal-configs/tree/master/configs```

Get ```droid.kmap``` and ```us.kmap```

Generate kmap files
===================

Now you can generate kmap file.

```
kmap2qmap usdvp.kmap am.kmap ge.kmap us.kmap droid.kmap noch.qmap
```

Copy to device
==============

You need to replace ```/usr/share/qt5/keymaps/boston.qmap``` file.

You may want to back it up first.

scp our the file to device

```
scp noch.qmap root@jolla.arnet.am:/usr/share/qt5/keymaps/
```

ssh to device and then

```
cd /usr/share/qt5/keymaps/
cp boston.qmap boston_.qmap
cp noch.qmap boston.qmap
```

Ok, now we have the layout, but we have no Dvorak or Armenian layouts in Settings -> Text input -> Hardware Keyboards -> Active Layout.

Edit hardware keyboards list on device
======================================

On device, edit ```/usr/share/jolla-settings/pages/text_input/textinput.qml``` file.

I have added Programmer's Dvorak and Armenian typewriter layouts like this:

```
        ListElement {
            layout: "am"
            name: "Armenian"
        }
        ListElement {
            layout: "us(dvp)"
            name: "Dvorak"
```

Reboot, and enjoy how it works!

Well, there is a problem, that if the bt keyboard is on, then the login screen of jolla requires you to use hardware keyboard to login, not the screen keyboard.
so i turn off the bt keyboard during restart.

Also, make sure you have wifi connection via ssh to the device in case something goes wrong, you would need to login to device and change things.






