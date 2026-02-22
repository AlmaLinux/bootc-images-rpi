ARG BASE=quay.io/almalinuxorg/almalinux-bootc-rpi:10

FROM $BASE

COPY 10-bootc-growpart.cfg /etc/cloud/cloud.cfg.d/
RUN \
  dnf install -y cloud-init cloud-utils-growpart &&\
  systemctl enable cloud-init && \
  sed -i 's@resize_what = "/"@resize_what = "/var"@' /usr/lib/python*/site-packages/cloudinit/config/cc_resizefs.py && \
  rm -f /usr/lib/python*/site-packages/cloudinit/config/cc_resizefs.pyc && \
  mkdir -p /usr/lib/systemd/system/ostree-finalize-staged.service.d && \
  echo '[Service]' > /usr/lib/systemd/system/ostree-finalize-staged.service.d/rpi-bootc-bootloader.conf && \
  echo 'ExecStop=' >> /usr/lib/systemd/system/ostree-finalize-staged.service.d/rpi-bootc-bootloader.conf && \
  echo 'ExecStop=/usr/bin/rpi-bootc-bootloader finalize-staged' >> /usr/lib/systemd/system/ostree-finalize-staged.service.d/rpi-bootc-bootloader.conf
