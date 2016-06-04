# Docker image for NativeScript CLI

## Description
NativeScript installation is pretty easy, but anyhow it requires additional steps. Most of people (and I'm one of them) just want to execute a one single command and start to work. And Docker is the right thing to do it. So why there shouldn't be an image for NativeScript CLI?

## Setup
All you need is just pull the image from Docker Hub and run it.

    docker pull m1burn/nativescript
    alias tns='docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD:/home/nativescript m1burn/nativescript tns'
    
The alias lets you to use 'tns' command. Otherwise, you have to type full command (docker run ... m1burn/nativescript tns) anytime you want to do anything. Thanks to [oreng](https://github.com/oren/docker-nativescript) for this great trick!

Also, I recommened to add the alias to ~/.bashrc file. Otherwise, if you close your terminal, you'll have to retype the alias again.
To add the alias to ~/.bashrc file, execute the command bellow.

    echo alias tns='docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD:/home/nativescript m1burn/nativescript tns' >> ~/.bashrc

## Build
If you want to build the image from Dockerfile, it is pretty easy to do.

    git clone https://github.com/m1burn/docker-nativescript.git
    cd docker-nativescript
    docker build -t nativescript .
    

## How to use it
Connect your Android device to computer through USB cable and make sure that you allowed debugging for that device. After that, try the following.

    tns create foo
    cd foo
    tns platform add android
    tns run android

If nothing bad happened, the test application should be runned on your device. After you have change some application code, you can redeploy  it by execute 'tns run android' again.

If execution of 'tns run android' is too slow for you, you can use awesome NativeScript CLI feature - 'livesync'.

    tns livesync --watch
    
After that, everytime you change your application code, NativeScript CLI will automatically re-deploy only modified files to your device.

## Known limitations
At the moment, the image doesn't supposed to work with emulator. It able to work only with physical devices. I hope, I'll remove this limitation in near future.
