# Docker image for [NativeScript](https://www.nativescript.org/) CLI

NativeScript installation is pretty easy, but anyhow it requires some additional steps. Most people (and I'm one of them) just want to execute one single command and start working. And Docker is the right thing to do it. So why shouldn't be there an image for NativeScript CLI?

## Setup
All you need to do is just pull the image from Docker Hub and run it.

    docker pull m1burn/nativescript
    alias tns='docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD:/home/nativescript m1burn/nativescript tns'

The alias lets you use 'tns' command. Otherwise you have to type a full command (docker run ... m1burn/nativescript tns) anytime you want to do anything. Thanks to [oreng](https://github.com/oren/docker-nativescript) for this great trick!

Also, I recommened to add this alias to ~/.bashrc file. Otherwise if you close your terminal you'll have to retype the alias again. To add the alias to ~/.bashrc file, execute the command bellow.

    echo "alias tns='docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v \$PWD:/home/nativescript m1burn/nativescript tns'" >> ~/.bashrc

## Build
If you want to build the image from Dockerfile, it is pretty easy to do.

    git clone https://github.com/m1burn/docker-nativescript.git
    cd docker-nativescript
    docker build -t nativescript .

## How to use it
Connect your Android device to computer through a USB cable and make sure that you are [allowed to debug that device](https://developer.android.com/studio/run/device.html). After that, try the following.

    mkdir nativescript-projects
    cd nativescript-projects
    tns create foo
    cd foo
    tns platform add android
    tns run android

If everything went right the test application should be running on your device. After you have made a change in some application code, you can redeploy it by executing the 'tns run android' again.

If execution of 'tns run android' is too slow for you, you can use this awesome NativeScript CLI feature - 'livesync'.

    tns livesync --watch

After that everytime you change your application code NativeScript CLI will automatically re-deploy the modified files to your device.

Please note that when you run command 'tns', it will try to create hidden directories (.local, .npm, .oracle_jre_usage) in your current directory. These directories are created by NativeScript CLI to keep it's settings. So it would be better if you choose to run this command in a special directory for NativeScript projects (even the first command 'tns create'). It can help you to avoid mixing these hidden directories with your own local directories.

## Known limitations
At the moment this image isn't supposed to work with an emulator. It is able to work only with physical devices.
