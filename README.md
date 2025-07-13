# AlmaLinux Bootable Container Base Images for RPI (bootc)

**<ins>Caution</ins>: AlmaLinux bootc images are currently *experimental*. Please use with care and report any issues.**

## Available Pre-built Images

Official pre-built experimental images are available on Quay.io:

* **[quay.io/almalinuxorg/almalinux-bootc-rpi](https://quay.io/repository/almalinuxorg/almalinux-bootc-rpi?tab=tags)**

This project provides tooling to build experimental AlmaLinux bootable container images. These images leverage the [bootc project](https://containers.github.io/bootc/), which enables the creation of bootable OS images from container images.

Our images are based on the work done for [CentOS Bootc Base Images](https://gitlab.com/redhat/centos-stream/containers/bootc/-/tree/c10s?ref_type=heads), [AlmaLinux Bootc Base Images](https://github.com/almalinux/bootc-images) and utilize [bootc-base-imagectl](https://gitlab.com/fedora/bootc/base-images/-/blob/main/bootc-base-imagectl.md?ref_type=heads) for their construction.

## Current Limitations

As an early and experimental project, we have not solved all problems with running AlmaLinux bootc images on the Raspberry Pis yet.

The project can be useful to folks despite these limitations for some use cases.

Things that work:
* installing the raw base image onto a rpi.
* building your own custom images based on the AlmaLinux RPI bootc image.
* switching the rpi to a custom image with a similar kernel to one the raw base image contained

Issues:
* firmware updating - You may need to perform some manual steps or reimage the pi
* devicetree management - the one that comes with the raw base image is used. When upgrading, it may need to be manually updated
* raw base image is only supported on rpi5 so far
* the initial setup requires more steps that necessary. We can make it smoother in the future
* because of the firmware issue, bootc-image-builder alone isn't enough to build a raw boot image

## Install Instructions

### Common Steps (RPI4 and RPI5)

Download and extract an image from Releases.

Flash it to an m.2 drive (RPI5 only), SD card, or USB device.

You can then look at the README.txt on the storage device along with customizing user-data as needed.

Move the storage device to the Pi.

### RPI5 specific steps

Boot it for the first time with a monitor and keyboard attached, as you will need to do a bit of initial setup.

When it starts, press `ESC` to get into the UEFI menu.

Select `Device Manager`

Select `Raspberry Pi Configuration`

Select `ACPI / Device Tree`

Change `System Table Mode` to `Device Tree`

Back out, save the config and reset the pi.

You should now have a bootable system.

## Project Status & News

* **[2025-06-10]** Forked repo for RPI specific images
* **[2024-09-02]** AlmaLinux announces experimental bootc support and HeliumOS: [Read the blog post](https://almalinux.org/blog/2024-09-02-bootc-almalinux-heliumos/)
* For the latest general information about AlmaLinux, visit [almalinux.org](https://almalinux.org/get-almalinux/).

## Building Images (Advanced)

This repository uses `make` to build the images locally.

### Prerequisites

* `make`
* A container runtime like `podman` or `docker` (ensure it's running and you have appropriate permissions).
* Sufficient disk space and internet connectivity.

### Build Instructions

The following examples demonstrate how to build specific variants:

### Example: AlmaLinux OS Kitten 10

```bash
make \
  PLATFORM=linux/arm64 \
  VARIANT=rpi \
  IMAGE_NAME=almalinux-bootc-rpi \
  VERSION_MAJOR=10-kitten-rpi
```

### Example: AlmaLinux OS 10 (arm64)

```bash
make \
  PLATFORM=linux/arm64 \
  VARIANT=rpi \
  IMAGE_NAME=almalinux-bootc-rpi \
  VERSION_MAJOR=10-rpi
```

### Example: AlmaLinux 9 (arm64)

```  
make \  
  PLATFORM=linux/arm64 \
  VARIANT=rpi \
  IMAGE_NAME=almalinux-bootc-rpi \
  VERSION_MAJOR=9-rpi
```

**Explanation of Build Variables:**

* `PLATFORM`: Specifies the target architecture and variant (e.g., linux/arm64).
* `VARIANT`: Which variant to build. (e.g. rpi).
* `IMAGE_NAME`: The base name for the output container image. (e.g. almalinux-bootc-rpi).
* `VERSION_MAJOR`: The AlmaLinux major version (e.g., 9-rpi, 10-rpi, 10-kitten-rpi).

## Contributing and Community

We welcome contributions and feedback!  
Join the discussion and get involved with the relevant AlmaLinux Special Interest Groups (SIGs):

* **Atomic SIG:** Focused on atomic updates and related tooling (like bootc).  
  * [Wiki](https://wiki.almalinux.org/sigs/Atomic.html)  
  * Chat: [Mattermost](https://chat.almalinux.org/almalinux/channels/sigatomic) | [Matrix](https://matrix.to/#/#sig-atomic:almalinux.im)  
* **Cloud SIG:** Focused on cloud images and deployments.  
  * [Wiki](https://wiki.almalinux.org/sigs/Cloud.html)  
  * Chat: [Mattermost](https://chat.almalinux.org/almalinux/channels/sigcloud) | [Matrix](https://matrix.to/#/#sig-cloud:almalinux.im)
