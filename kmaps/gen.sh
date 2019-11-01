ckbcomp -keycodes evdev -layout us -variant dvp > usdvp.kmap
ckbcomp -keycodes evdev -layout am > am.kmap
ckbcomp -keycodes evdev -layout am -variant phonetic > amph.kmap
ckbcomp -keycodes evdev -layout ru -variant phonetic > ruph.kmap
ckbcomp -keycodes evdev -layout ge > ge.kmap
ckbcomp -keycodes evdev -layout cn > cn.kmap
ckbcomp -keycodes evdev -layout cn > cn.kmap
ckbcomp -keycodes evdev -layout cn -variant altgr-pinyin > cn-pinyin.kmap

#kmap2qmap am.kmap amph.kmap ge.kmap ruph.kmap usdvp.kmap ../jolla_kmaps/us.kmap ../jolla_kmaps/droid.kmap inky.qmap
kmap2qmap am.kmap amph.kmap ge.kmap ruph.kmap usdvp.kmap cn.kmap cn-pinyin.kmap ../jolla_kmaps/us.kmap ../jolla_kmaps/droid.kmap inky.qmap

