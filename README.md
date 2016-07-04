Your Distro From Scratch 2.* is buildt from Debian8 (x86 and x86_64), you will need recent building tools to make it successfull

#Build ydfs ISO


```
#!shell

sudo apt-get install git
cd $HOME
```


```
#!shell

 install -d src
 cd src
 git clone https://bitbucket.org/yledoare/ydfs.git
 cd ydfs
 cd 2.5
 sudo sh configure
 make
```
