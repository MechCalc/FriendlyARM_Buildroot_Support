## FriendlyARM Buildroot Support ##
This is a collection of files for use with [Buildroot](http://buildroot.uclibc.org/) RootFS/Kernel build system. The pre-canned setups provided are very basic, both for Userspace and the Kernels, allowing the user to configure in just what they require.

### Currently Supported Boards ###
* 210 Series boards.

## Installation ##
First is to get a copy of Buildroot.

    $ wget http://buildroot.uclibc.org/downloads/buildroot-2014.05.tar.gz
    $ tar -xf buildroot-2014.05.tar.gz

Next is to download these support files, to anywhere you want, but inside the Buildroot tree is not recommended.

    $ git clone https://github.com/MechCalc/FriendlyARM_Buildroot_Support.git

## Configuring Buildroot ##
If you look in the _FriendlyARM\_Buildroot\_Support/configs_ directory, there will be some defconfig files, decide on the one you'd like to use. Their names have a bit of a description, fa210_yaffs2_min_defconfig, for example, is for a 210 series board, using the Yaffs2 filesystem, and very minimal additions. When done open a terminal in the Buildroot directory and run.

    $ make BR2_EXTERNAL=/path/to/FriendlyARM_Buildroot_Support fa210_yaffs2_min_defconfig

Note the BR2_EXTERNAL, this sets the path to this Support pacakge, it will need to be set on first run, and after make cleans. It tells buildroot where to find this package. With this set up it allows you to run git pull in your Buildroot directory, to pull in the latest updates, with out causing issues or conflicts. Same with this repo.

Now you can add and configure to your specific needs. Both Buildroot and Busybox have Packages options where you can specify what applications you want to install. Busybox is more base needs, while Buildroot has more specific user applications.

**Configure Buildroot options.**

    $ make menuconfig

**Configure Linux kernel options.**

    $ make linux-menuconfig

**Configure Busybox options.**

    $ make busybox-menuconfig

## Compiling ##
Once you've got it configured, just run.

    $ make

Depending on your machine and options selected this could take a few minutes to a few hours.

Once done, look in the _Buildroot/output/images_ directory, and you should find rootfs.yaffs2 and zImage, ready to put on your SD Card to install with Superboot.

## Additional Features ##
There are some extra features, such as SDIO Wifi that require addition configuration, in the FriendlyARM_Buildroot_Support/docs directory, you'll see wifi.readme, this explains the steps to take. It can also be useful for getting started with a different WiFi solution.

