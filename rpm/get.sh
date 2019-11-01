DEVICE=192.168.3.11

scp root@$DEVICE:/root/rpmbuild/SPECS/keyboard-hw-inky.spec .

scp root@$DEVICE:/root/rpmbuild/SRPMS/* .

scp root@$DEVICE:/root/rpmbuild/RPMS/noarch/* .
