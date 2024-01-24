function install_docker_engine
{
  TARBALL=https://download.docker.com/linux/static/stable/x86_64/docker-20.10.12.tgz
  cd $HOME
  [ ! -e `basename $TARBALL` ] && wget $TARBALL 
  [ ! -e docker ] && tar xzvf `basename $TARBALL`
  cp -a docker/* /usr/bin
}

function enable_docker_engine
{

set -e
if grep -v '^#' /etc/fstab | grep -q cgroup; then
	echo 'cgroups mounted from fstab, not mounting /sys/fs/cgroup'
	exit 0
fi
if [ ! -e /proc/cgroups ]; then
	exit 0
fi
if [ ! -d /sys/fs/cgroup ]; then
	exit 0
fi

mount -t tmpfs -o uid=0,gid=0,mode=0755 cgroup /sys/fs/cgroup
cd /sys/fs/cgroup

for sys in $(awk '!/^#/ { if ($4 == 1) print $1 }' /proc/cgroups); do
	mkdir -p $sys
		if ! mount -n -t cgroup -o $sys cgroup $sys; then
			rmdir $sys || true
		fi
done

}

which docker || install_docker_engine
enable_docker_engine
[ ! -e /var/lib/docker ] && ln -s /media/ydfs/docker /var/lib
DOCKER_RAMDISK=true dockerd 
