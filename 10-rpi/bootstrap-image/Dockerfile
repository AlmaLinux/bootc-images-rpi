ARG BASE=quay.io/almalinuxorg/almalinux-bootc-rpi:10

FROM $BASE

COPY 10-bootc-growpart.cfg /etc/cloud/cloud.cfg.d/
RUN \
  dnf install -y cloud-init cloud-utils-growpart &&\
  systemctl enable cloud-init && \
  sed -i 's@resize_what = "/"@resize_what = "/var"@' /usr/lib/python*/site-packages/cloudinit/config/cc_resizefs.py && \
  rm -f /usr/lib/python*/site-packages/cloudinit/config/cc_resizefs.pyc
