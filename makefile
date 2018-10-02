all:
		kmaps qmap backup sync
kmaps:
		ckbcomp -keycodes evdev -layout us -variant dvp > usdvp.kmap
		ckbcomp -keycodes evdev -layout am > am.kmap
		ckbcomp -keycodes evdev -layout ge > ge.kmap	
		ckbcomp -keycodes evdev -layout ru -variant phonetic > ru.kmap	
qmap:
		./kmap2qmap am.kmap ge.kmap ru.kmap usdvp.kmap jolla_kmaps/us.kmap jolla_kmaps/droid.kmap noch.qmap
backup:
		ssh root@jolla "cp /usr/share/qt5/keymaps/boston.qmap /usr/share/qt5/keymaps/boston.qmap_bak"
sync:
		scp noch.qmap root@jolla:/usr/share/qt5/keymaps/boston.qmap
reboot:
		ssh root@10.23.23.5 "reboot"

