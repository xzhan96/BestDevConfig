#!/bin/sh
#generate tag file for lookupfile plugin
#echo - e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
#  find. - not - regex '.*\.\(png\|gif\)' - type f -
#  printf "%f\t%p\t1\n" | sort - f >> filenametags
#generate tag file for lookupfile plugin
  echo "!_TAG_FILE_SORTED 2       /2=foldcase/" >./filenametags
  find $PWD \
  -name ".svn" -prune \
  -or -name ".git" -prune \
  -or -type f -printf "%f\t%p\t1\n" | sort -f >>./filenametags
