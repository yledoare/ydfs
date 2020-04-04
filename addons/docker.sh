if grep -v '^#' /etc/fstab | grep -q cgroup; then
	echo 'cgroups mounted from fstab, not mounting /sys/fs/cgroup'
else
	mount -t tmpfs -o uid=0,gid=0,mode=0755 cgroup /sys/fs/cgroup
fi

cd /sys/fs/cgroup

for sys in $(awk '!/^#/ { if ($4 == 1) print $1 }' /proc/cgroups); do
	mkdir -p $sys
		if ! mount -n -t cgroup -o $sys cgroup $sys; then
			rmdir $sys || true
		fi
done

[ ! -e /usr/bin/docker ] && cd $HOME && wget https://download.docker.com/linux/static/stable/x86_64/docker-19.03.8.tgz && tar xzvf docker-19.03.8.tgz && mv docker/* /usr/bin
[ ! -e /media/ydfs/docker ] && install -d /media/ydfs/docker
[ ! -e /var/lib/docker ] && ln -s /media/ydfs/docker /var/lib
DOCKER_RAMDISK=true dockerd
