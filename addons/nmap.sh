# bash nmap.sh -sn 192.168.1.0/24
SKIP_DEP=ON ./apt-get install liblua5.3-0
SKIP_DEP=ON ./apt-get install lua-lpeg
SKIP_DEP=ON ./apt-get install liblinear4
SKIP_DEP=ON ./apt-get install libpcap0.8
SKIP_DEP=ON ./apt-get install libblas3
SKIP_DEP=ON ./apt-get install nmap
LD_LIBRARY_PATH=$HOME/.local/usr/lib/x86_64-linux-gnu/:$HOME/.local/usr/lib/x86_64-linux-gnu/blas:$LD_LIBRARY_PATH nmap $@
