#!/bin/bash
basepath=/home/pi/mtv-movies-svelte2.0;

builddir=$basepath/build;

git pull https://github.com/cjsmocjsmo/mtv-movies-svelte2.0.git;

rm -rf $builddir;

npm install;

npm run build;

arch=$(uname -m);

if [ "$arch" = "armv7l" ]; then
    docker stop mtvmovsvelt_arm32;
    docker rm mtvmovsvelt_arm32;
    docker rmi mtvmovsvelte:arm32;
    docker build -t mtvmovsvelte:arm32 -f ./arm32/Dockerfile .;
    docker run --name mtvmovsvelt_arm32 -d -p 8090:80 mtvmovsvelte:arm32;
fi

if [ "$arch" = "aarch64" ]; then
    docker stop mtvmovsvelt_arm64;
    docker rm mtvmovsvelt_arm64;
    docker rmi mtvmovsvelte:arm64;
    docker build -t mtvmovsvelte:arm64 -f ./arm64/Dockerfile .;
    docker run --name mtvmovsvelt_arm64 -d -p 8090:80 mtvmovsvelte:arm64;
fi

if [ "$arch" = "x86_64" ]; then
    docker stop mtvmovsvelt_amd64;
    docker rm mtvmovsvelt_amd64;
    docker rmi mtvmovsvelte:amd64;
    docker build -t mtvmovsvelte:amd64 -f ./amd64/Dockerfile .;
    docker run --name mtvmovsvelt_amd64 -d -p 8090:80 mtvmovsvelte:amd64;
fi

if [ "$arch" = "i386" ]; then
    echo "This archatecture is not supported"
    exit 1
fi
