ARG ANSIBLE_VERSION
ARG DEBIAN_BUILD_IMAGE
ARG ANSIBLE_VAULT_VERSION
ARG ANSIBLE_NOMAD_VERSION
ARG ANSIBLE_CONSUL_VERSION

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
RUN pip install --no-cache-dir boto3 ansible-modules-hashivault hvac \
 && ansible-galaxy install "git+https://github.com/ansible-community/ansible-vault.git,${ANSIBLE_VAULT_VERSION}" \
 && ansible-galaxy install "git+https://github.com/ansible-community/ansible-nomad.git,${ANSIBLE_NOMAD_VERSION}" \
 && ansible-galaxy install "git+https://github.com/ansible-community/ansible-consul.git,${ANSIBLE_CONSUL_VERSION}" \
 && ansible-galaxy collection install community.hashi_vault
