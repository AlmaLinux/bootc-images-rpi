PODMAN = sudo podman

IMAGE_NAME = almalinux-bootc-rpi
VERSION_MAJOR = 10
PLATFORM = linux/amd64
VARIANT = general
LABELS ?=

ifeq ($(VARIANT), general)
    SUFFIX =
else
    SUFFIX = -$(VARIANT)
endif

.ONESHELL:
.PHONY: all
all: rechunk

.PHONY: image
image:
	$(PODMAN) build \
		--platform=$(PLATFORM) \
		--security-opt=label=disable \
		--cap-add=all \
		--device /dev/fuse \
		--iidfile /tmp/image-id \
		$(LABELS) \
		-t $(IMAGE_NAME) \
		-f $(VERSION_MAJOR)$(SUFFIX)/Containerfile \
		.

rechunk:
	$(PODMAN) run \
		--rm --privileged \
		--security-opt=label=disable \
		-v /var/lib/containers:/var/lib/containers:z \
		quay.io/centos-bootc/centos-bootc:stream10 \
		/usr/libexec/bootc-base-imagectl rechunk \
		localhost/$(IMAGE_NAME):latest localhost/rechunked-$(IMAGE_NAME):latest && \
	$(PODMAN) tag localhost/rechunked-$(IMAGE_NAME):latest localhost/$(IMAGE_NAME):latest && \
	$(PODMAN) rmi localhost/rechunked-$(IMAGE_NAME):latest
