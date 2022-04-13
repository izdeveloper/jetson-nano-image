<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue)]()
</div>

## Spec:
**Ubuntu release**: 18.04

**BSP**: 32.4

## How to build image

    docker-compose run builder bash

Then inside docker container copy rootfs to host system:
    
    cp -r /rootfs /output 
    

## Original Instructions here:

https://pythops.com/post/create-your-own-image-for-jetson-nano-board.html

## Supported boards:
- [Jetson nano](https://developer.nvidia.com/embedded/jetson-nano-developer-kit)
- [Jetson nano 2GB](https://developer.nvidia.com/embedded/jetson-nano-2gb-developer-kit)

## License
Copyright Badr BADRI @pythops

MIT
