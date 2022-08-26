#!/usr/bin/env bash
#
# Free Pascal installation script for Unixy platforms.
# Copyright 1996-2004 Michael Van Canneyt, Marco van de Voort and Peter Vreman
#
# Don't edit this file.
# Everything can be set when the script is run.
#

# Release Version will be replaced by makepack
VERSION=$FREEPASCAL
FULLVERSION=$FREEPASCAL

# some useful functions
# ask displays 1st parameter, and ask new value for variable, whose name is
# in the second parameter.
ask ()
{
  return 0;
  askvar=$2
  eval old=\$$askvar
  eval printf \""$1 [$old] : "\"
  read $askvar
  eval test -z \"\$$askvar\" && eval $askvar=\'$old\'
}

# yesno gives 1 on no, 0 on yes $1 gives text to display.
yesno ()
{
  return 0;
}
#
#
#
CMDGREP="grep"
CMDGGREP="`which ggrep 2> /dev/null`"
if [ -f "$CMDGGREP" ] ; then
  CMDGREP="$CMDGGREP"
  echo "Using GREP binary=$CMDGREP"
fi
grep_version=`$CMDGREP --version 2> /dev/null `
grep_version_res=$?
if [ $grep_version_res -ne 0 ] ; then
  echo "Installed grep command $CMDGREP does not support --version"
  grep_version=""
fi

is_gnu_grep=1
grep_silent_opt="-q"

CMDTAR="tar"
# Use GNU tar if present
CMDGTAR="`which gtar 2> /dev/null`"
if [ -f "$CMDGTAR" ]; then
  CMDTAR="$CMDGTAR"
  echo "Using TAR binary=$CMDTAR"
fi

tar_version=`$CMDTAR --version 2> /dev/null `
tar_version_res=$?
if [ $tar_version_res -ne 0 ] ; then
  echo "Installed tar command $CMDTAR does not support --version"
  tar_version=""
fi

if [ "${tar_version//GNU/}" != "${tar_version}" ] ; then
  is_gnu_tar=1
  no_same_owner_tar_opt=--no-same-owner
  strip_tar_opt="--strip 1"
  use_gunzip=0
else
  is_gnu_tar=0
  no_same_owner_tar_opt=
  strip_tar_opt=
  use_gunzip=1
fi

TAR="$CMDTAR $no_same_owner_tar_opt"
# Untar files ($3,optional) from  file ($1) to the given directory ($2)
unztar ()
{
 if [ $use_gunzip -eq 0 ] ; then
   $TAR -xzf "$HERE/$1" -C "$2" $3
 else
   startdir="`pwd`" 
   targzfile="$HERE/$1"
   tarfile="${targzfile/tar.gz/tar}"
   if [ ! -f "$tarfile" ] ; then
     gunzip "$targzfile"
   fi
   cd "$2"
   $TAR -xf "$tarfile" $3
   cd "$startdir"
 fi
}

# Untar tar.gz file ($2) from file ($1) and untar result to the given directory ($3)
unztarfromtar ()
{
 if [ $use_gunzip -eq 0 ] ; then
   $CMDTAR -xOf "$HERE/$1" "$2" | $TAR -C "$3" -xzf -
 else
   startdir="`pwd`"
   $CMDTAR -xf "$HERE/$1" "$2"
   targzfile="$startdir/$2"
   tarfile="${targzfile/tar.gz/tar}"
   if [ ! -f "$tarfile" ] ; then
     gunzip "$targzfile"
   fi
   cd "$3"
   $TAR -xf "$tarfile"
   res=$?
   if [ $res -eq 0 ] ; then
     rm -f "$2"
   fi
   cd "$startdir"
 fi
}

# Get file list from tar archive ($1) in variable ($2)
# optionally filter result through sed ($3)
listtarfiles ()
{
  askvar="$2"
  if [ ! -z "$3" ]; then
    list=`$CMDTAR tvf "$1" | awk '{ print $(NF) }' | sed -n /"$3"/p`
  else
     list=`$CMDTAR tvf "$1" | awk '{ print $(NF) }'`
  fi
  eval $askvar='$list'
}

# Make all the necessary directories to get $1
makedirhierarch ()
{
  mkdir -p "$1"
}

# check to see if something is in the path
checkpath ()
{
 ARG="$1"
 OLDIFS="$IFS"; IFS=":";eval set "$PATH";IFS="$OLDIFS"
 for i
 do
   if [ "$i" = "$ARG" ]; then
     return 0
   fi
 done
 return 1
}

# Install files from binary-*.tar
#  $1 = cpu-target
#  $2 = cross prefix
installbinary ()
{
  if [ "$2" = "" ]; then
    FPCTARGET="$1"
    CROSSPREFIX=
    PPCPREFIX=ppc
  else
    FPCTARGET=`echo $2 | sed 's/-$//'`
    CROSSPREFIX="$2"
    PPCPREFIX=ppcross
  fi

  BINARYTAR="${CROSSPREFIX}binary.$1.tar"

  # Select CPU part of FPCTARGET
  PPCSUFFIX=${FPCTARGET/-*/}
  # conversion from long to short archname for ppc<x>
  case $PPCSUFFIX in
    aarch64)
      PPCSUFFIX=a64;;
    alpha)
      PPCSUFFIX=axp;;
    m68k)
      PPCSUFFIX=68k;;
    i386)
      PPCSUFFIX=386;;
    i8086)
      PPCSUFFIX=8086;;
    powerpc)
      PPCSUFFIX=ppc;;
    powerpc64)
      PPCSUFFIX=ppc64;;
    riscv32)
      PPCSUFFIX=rv32;;
    riscv64)
      PPCSUFFIX=rv64;;
    x86_64)
      PPCSUFFIX=x64;;
  esac

  # Install compiler/RTL. Mandatory.
  echo "Installing compiler and RTL for $FPCTARGET..."
  # Full install builds cross generated on x86_64-linux have a different name for base tar.gz file
  basetargz=`$CMDTAR -tf "$BINARYTAR" | sed -n -e "/^base.*tar\.gz/p" -e "/^$FPCTARGET-base.*tar\.gz/p" | head -1 `
  if [ -n "$basetargz" ] ; then
    unztarfromtar "$BINARYTAR" "$basetargz" "$PREFIX"
  else
    unztarfromtar "$BINARYTAR" "${CROSSPREFIX}base.$1.tar.gz" "$PREFIX"
  fi

  if [ -f "binutils-${CROSSPREFIX}$1.tar.gz" ]; then
    if yesno "Install Cross binutils"; then
      unztar "binutils-${CROSSPREFIX}$1.tar.gz" "$PREFIX"
    fi
  fi

  # Install symlink
  if [ -f "$LIBDIR/${PPCPREFIX}${PPCSUFFIX}" ] ; then
    rm -f "$EXECDIR/${PPCPREFIX}${PPCSUFFIX}"
    ln -sf "$LIBDIR/${PPCPREFIX}${PPCSUFFIX}" "$EXECDIR/${PPCPREFIX}${PPCSUFFIX}"
  elif [ -f "$LIBDIR/ppc${PPCSUFFIX}" ] ; then
    rm -f "$EXECDIR/ppc${PPCSUFFIX}"
    ln -sf "$LIBDIR/ppc${PPCSUFFIX}" "$EXECDIR/ppc${PPCSUFFIX}"
  else
    echo "Warning: Compiler for $FPCTARGET not found"
  fi

  echo "Installing rtl packages..."
  listtarfiles "$BINARYTAR" packages units-rtl
  for f in $packages
  do
    p=`echo "$f" | sed -e 's+^.*units-\([^\.]*\)\..*+\1+'`
	echo "Installing $p"
    unztarfromtar "$BINARYTAR" "$f" "$PREFIX"
  done

  echo "Installing fcl..."
  listtarfiles "$BINARYTAR" packages units-fcl
  for f in $packages
  do
    p=`echo "$f" | sed -e 's+^.*units-\([^\.]*\)\..*+\1+'`
	echo "Installing $p"
    unztarfromtar "$BINARYTAR" "$f" "$PREFIX"
  done

  echo "Installing packages..."
  listtarfiles "$BINARYTAR" packages units
  for f in $packages
  do
    if ! echo "$f" | $CMDGREP $grep_silent_opt fcl > /dev/null ; then
      if ! echo "$f" | $CMDGREP $grep_silent_opt rtl > /dev/null ; then
        p=`echo "$f" | sed -e 's+^.*units-\([^\.]*\)\..*+\1+'`
	echo "Installing $p"
        unztarfromtar "$BINARYTAR" "$f" "$PREFIX"
      fi
    fi
  done

  echo "Installing utilities..."
  listtarfiles "$BINARYTAR" packages ${CROSSPREFIX}utils
  for f in $packages
  do
    p=`echo "$f" | sed -e 's+^.*utils-\([^\.]*\)\..*+\1+' -e 's+^.*\(utils\)[^\.]*\..*+\1+'`
	echo "Installing $p"
    unztarfromtar "$BINARYTAR" "$f" "$PREFIX"
  done

  # Should this be here at all without a big Linux test around it?
  if [ "x$UID" = "x0" ]; then
    chmod u=srx,g=rx,o=rx "$PREFIX/bin/grab_vcsa"
  fi

  ide=`$TAR -tf $BINARYTAR | grep "${CROSSPREFIX}ide.$1.tar.gz"`
  if [ "$ide" = "${CROSSPREFIX}ide.$1.tar.gz" ]; then
    if yesno "Install Textmode IDE"; then
      unztarfromtar "$BINARYTAR" "${CROSSPREFIX}ide.$1.tar.gz" "$PREFIX"
    fi
  fi

  rm -f *."$1".tar.gz
}


# --------------------------------------------------------------------------
# welcome message.
#

clear
echo "This shell script will attempt to install the Free Pascal Compiler"
echo "version $FULLVERSION with the items you select"
echo

# Here we start the thing.
HERE=`pwd`

OSNAME=`uname -s | tr "[:upper:]" "[:lower:]"`
case "$OSNAME" in
  haiku)
     # Install in /boot/common or /boot/home/config ?
     if checkpath /boot/common/bin; then
         PREFIX=/boot/common
     else
         PREFIX=/boot/home/config
     fi
     # If we can't write on prefix, we are probably 
     # on Haiku with package management system.
     # In this case, we have to install fpc in the non-packaged subdir
     if [ ! -w "$PREFIX" ]; then
     	PREFIX="$PREFIX/non-packaged"
     fi
  ;;
  freebsd)
     PREFIX=/usr/local
  ;;
  sunos)
     # Check if GNU llinker is recent enough, version 2.21 is needed at least
     GNU_LD=`which gld`
     supported_emulations=`"$GNU_LD" --target-help | sed -n "s|^\(elf.*\):|\1|p" `
     supports_elf_i386_sol2=`echo $supported_emulations | grep -w elf_i386_sol2 `
     supports_elf_x86_64_sol2=`echo $supported_emulations | grep -w elf_x86_64_sol2 `
     if [ "$supports_elf_i386_sol2" = "" ]; then
       echo -n "GNU linker $GNU_LD does not support elf_i386_sol2 emulation, please consider "
       echo "upgrading binutils package to at least version 2.21"
     elif [ "$supports_elf_x86_64_sol2" = "" ]; then
       echo -n "GNU linker $GNU_LD does not support elf_x86_64_sol2 emulation, please consider "
       echo "upgrading binutils package to at least version 2.21"
     fi
     PREFIX=/usr/local
  ;;
  aix)
     # Install in /usr/local or /usr ?
     if checkpath /usr/local/bin; then
         PREFIX=/usr/local
     else
         PREFIX=/usr
     fi
  ;;
  *)
     # Install in /usr/local or /usr ?
     if checkpath /usr/local/bin; then
         PREFIX=/usr/local
     else
         PREFIX=/usr
     fi
  ;;
esac

# If we can't write on prefix, select subdir of home dir
PREFIX="$HOME/fpc-$VERSION"

case "$OSNAME" in
  haiku)
     ask "Install prefix (/boot/common or /boot/home/config) " PREFIX
  ;;
  *)
     ask "Install prefix (/usr or /usr/local) " PREFIX
  ;;
esac

# Support ~ expansion
PREFIX=`eval echo $PREFIX`
export PREFIX
makedirhierarch "$PREFIX"

# Set some defaults.
LIBDIR="$PREFIX/lib/fpc/$VERSION"
SRCDIR="$PREFIX/src/fpc-$VERSION"
EXECDIR="$PREFIX/bin"

BSDHIER=0
case "$OSNAME" in
*bsd)
  BSDHIER=1;;
esac

SHORTARCH="$ARCHNAME"
FULLARCH="$ARCHNAME-$OSNAME"
DOCDIR="$PREFIX/share/doc/fpc-$VERSION"

case "$OSNAME" in
  freebsd)	
     # normal examples are already installed in fpc-version. So added "demo"
     DEMODIR="$PREFIX/share/examples/fpc-$VERSION/demo"
     ;;
  *)
     DEMODIR="$DOCDIR/examples"
     ;;
esac

# Install all binary releases
for f in *binary*.tar
do
  target=`echo $f | sed 's+^.*binary\.\(.*\)\.tar$+\1+'`
  cross=`echo $f | sed 's+binary\..*\.tar$++'`

  # cross install?
  if [ "$cross" != "" ]; then
    if [ "`which fpc 2>/dev/null`" = '' ]; then
      echo "No native FPC found."
      echo "For a proper installation of a cross FPC the installation of a native FPC is required."
      exit 1
    else
      if [ `fpc -iV` != "$VERSION" ]; then
        echo "Warning: Native and cross FPC doesn't match; this could cause problems"
      fi
    fi
  fi
  installbinary "$target" "$cross"
done

echo Done.
echo

# Install the documentation. Optional.
if [ -f doc-pdf.tar.gz ]; then
  if yesno "Install documentation"; then
    echo Installing documentation in "$DOCDIR" ...
    makedirhierarch "$DOCDIR"
    unztar doc-pdf.tar.gz "$DOCDIR" "$strip_tar_opt"
    echo Done.
  fi
fi
echo

# Install the demos. Optional.
if [ -f demo.tar.gz ]; then
  if yesno "Install demos"; then
    ask "Install demos in" DEMODIR
    echo Installing demos in "$DEMODIR" ...
    makedirhierarch "$DEMODIR"
    unztar demo.tar.gz "$DEMODIR"
    echo Done.
  fi
fi
echo

# Post substitution of FPC_VERSION to $fpc_version in cfg scripts
subst_pattern=ask

function substitute_version_string ()
{
  file=$1
  has_version=`grep $VERSION $file`
  if [ ! -z "$has_version" ] ; then
    if [ "$subst_pattern" == "ask" ] ; then
      if yesno "Subtitute $VERSION by \$fpcversion in config files"; then
        subst_pattern=yes
      else
        subst_pattern=no
      fi
    fi
    if [ "$subst_pattern" == "yes" ] ; then
      has_dollar_fpcversion=`grep '\$fpcversion' $file`
      has_CompilerVersion=`grep '\{CompilerVersion\}' $file`
      if [ -n "$has_dollar_fpcversion" ] ; then
        echo "File $file contains string \"$VERSION\", trying to subtitute with \"\$fpcversion\""
        sed "s:$VERSION:\$fpcversion:g" $file > $file.tmp
        sed_res=$?
        if [ $sed_res -eq 0 ] ; then
          mv -f $file.tmp $file
        else
          echo "sed failed, res=$sed_res"
        fi
      elif [ -n "$has_CompilerVersion" ] ; then
        echo "File $file contains string \"$VERSION\", trying to subtitute with \"{CompilerVersion}\""
        sed "s:$VERSION:\{CompilerVersion\}:g" $file > $file.tmp
        sed_res=$?
        if [ $sed_res -eq 0 ] ; then
          mv -f $file.tmp $file
        else
          echo "sed failed, res=$sed_res"
        fi
      fi
    fi
  fi
}

# Install /etc/fpc.cfg, this is done using the samplecfg script
if [ "$cross" = "" ]; then
  "$LIBDIR/samplecfg" "$LIBDIR" | tee samplecfg.log
  file_list=`sed -n 's:.*Writing sample configuration file to ::p' samplecfg.log`
  if [ ! -z "$file_list" ] ; then
    for file in $file_list ; do
      if [ -w $file ] ; then
        substitute_version_string $file
      fi
    done
  fi
  rm samplecfg.log
else
  echo "No fpc.cfg created because a cross installation has been done."
fi

# The End
echo
echo End of installation.
echo
echo Refer to the documentation for more information.
echo
