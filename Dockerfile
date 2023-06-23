ARG ANSIBLE_VERSION
ARG DEBIAN_BUILD_IMAGE
ARG CI_COMMIT_SHA

# hadolint ignore=DL3006
FROM $DEBIAN_BUILD_IMAGE

# hadolint ignore=DL3008
RUN apt-get update -qqy \
 && apt-get install -qqy --no-install-recommends \
  python3 \
  python3-pip \
  python3-setuptools \
  python3-virtualenv \
  git \
  unzip \
  sshpass \
  curl \
  ansible="${ANSIBLE_VERSION}*"  \
  python-is-python3 \
 && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3013
RUN pip install --no-cache-dir --break-system-packages \
    ansible-modules-hashivault \
    hvac \
    python-nomad \
 && ansible-galaxy install "git+https://gitlab.com/Deltamir/ansible-hashistack.git,${CI_COMMIT_SHA}"
