#!/bin/bash

./build_docker.sh || exit $?

# git equivalent to "svn export"...
echo "exporting source"
rm -rf exported_source/ || exit 1
mkdir -p exported_source/ || exit 1
(cd .. && git checkout-index -a --prefix=docker_build/exported_source/) || exit 1

# but we don't want (or need) this build directory
rm -rf exported_source/docker_build

echo "running docker build"
docker run --rm  --volume=`pwd`/exported_source:/shared:z microbit-mkdocs

#docker run --rm -i -t --entrypoint=  --volume=`pwd`/exported_source:/shared:z microbit-mkdocs bash

# TODO set permissions / generate RPM

echo "generating tarfile (NB tarbomb)"
rm -f microbit_book.tgz
(cd exported_source/site && tar cfz ../../microbit_book.tgz *)

#echo "cleanup"
#rm -rf exported_source/
