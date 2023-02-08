Ansible-Hashistack
=========

This role leverage the [ansible-consul](https://github.com/ansible-community/ansible-consul), 
[ansible-nomad](https://github.com/ansible-community/ansible-nomad) and 
[ansible-vault](https://github.com/ansible-community/ansible-vault) roles to deploy 
[Consul](https://www.consul.io/), 
[Nomad](https://www.nomadproject.io/) and 
[Vault](https://www.vaultproject.io/) clusters in a **simple**, **secure** and **flexible** way  

*Why simple ?*  
For starter, it's one role and not three... 
And this role use sanes defaults in order to provide an easy configuration with only a handful mandatory variables. See the [examples](./examples/inventory).  
Contrary to the aforementioned roles, we provide a [container](https://hub.docker.com/r/deltamir/ansible-hashistack) that can be use to deploy your clusters manually or be integrated in a CD.


*Why secure ?*  
This role is not a simple merge between three existing community-supported projects. On top of thoses, it will configure as well :
1. Automatic **Gossip Key rotation** with user-defined interval for both Nomad and Consul clusters leveraging a consul-template systemd service
2. **PKI management** for Consul, Nomad and Vault with individual certificates for each binary and each node in order to achieve full mTLS across clusters
3. Automatic **mTLS Certificate Key rotation** with user-defined interval for Nomad, Consul and Vault leveraging a consul-template systemd service 
4. **Vault auto-unseal** with Transit Secret Engine against a master Vault configured by this role
5. **Cross ACL management** for Consul and Nomad using Vault's secret providers **(TODO)**

*Why flexible ?*  
The amazing configurability provided by  [ansible-consul](https://github.com/ansible-community/ansible-consul),
[ansible-nomad](https://github.com/ansible-community/ansible-nomad) and
[ansible-vault](https://github.com/ansible-community/ansible-vault) through their variables is not overrided by our role.  
This way you can configure and adjust your clusters to your needs with thoses variables. Check the documentations of theses individual roles for more informations.


Requirements
------------
### Pip and package dependencies

If not used within our container image, the role have the following dependencies :  
``
apt-get install unzip curl  
``  
``
pip install ansible-modules-hashivault hvac
``

### Global Vault

In order to configure a PKI, enable automatic rotation of both certificates and gossip key AND unseal your Vault cluster, this role leverage a **master Vault**.  

*What is this master Vault ?*  
It simply is another Hashicorp Vault instance you own :
1. Accessible from your cluster
2. Accessible from your ansible-enabled deployment host (or the container)
3. You have at least the following permissions on this instance :
   - **TBD**
   - **TBD**

*What data will I intrust to the master Vault ?*  
Sensitives ones. This role uses the K/V secret engine to hold the gossip keys, the Transit secret engine with capabilities to unseal you cluster and 3 PKI secret engines with 1 CA signing you mTLS certificates

The master Vault does not need to be populated or configured whatsoever, this role will take care of this for you.

**TODO** *Diagram showing the deployment process with a master Vault*  

A small [HCP Vault](https://portal.cloud.hashicorp.com/sign-up?product_intent=vault) instance is a great candidate for this job, but if you won't deploy in a production-ready environment you can as well use a [dev instance](https://developer.hashicorp.com/vault/docs/concepts/dev-server) on your laptop or a small IOT device. 

Role Variables
--------------

This role have 6 mandatory variables. See the [examples](./examples/inventory).  

### `global_vault_adress`
- URL of the master Vault
- Example: http://[hcp_url]:8200

### `global_vault_token`
- Token used to configure the master Vault. Needs create_orphan in order to create child token for the services
- Needs the following permissions : **TBD**

### `node_name`
- Name of the node as seen by Consul and Nomad
- Setted per-host
- Can be overidden by `consul_node_name` and `nomad_node_name` from parent roles

### `consul_node_role`
- The Consul role of the node, one of: *server* or *client*
- Default value: client
- Setted per-host ; Currently tested only with *server* for all nodes, so be sure to override it
- This role does not support *bootstrap* like ansible-consul role

### `nomad_node_role`
- The Nomad role of the node, one of: *server*, *client* or *both*
- Default value: client
- Setted per-host ; Currently tested only with *both*, so be sure to override it

### `consul_template_version`
- Version of the consul_template binary to use
- Check the last release [here](https://releases.hashicorp.com/consul-template/)

### `consul_version`, `nomad_version`, `vault_version`
- Theses are not mandatory but are recommended
- The default values are thoses from their respective parent jobs

Examples
----------------

Example playbook [here](./examples/playbook.yml) :

```
- name: Assemble Hashistack cluster
  hosts: instances
  any_errors_fatal: true
  become: true
  become_user: root
  roles:
    - {role: ansible_hashistack}
```

Usage via the container Image :  
**TODO**
```
docker pull deltamir/ansible-hashistack
```

Installation from Galaxy
```
ansible-galaxy install deltamir.ansible_hashistack
```

License
-------

[BSD 2-Clause "Simplified"](LICENSE)

Author Information
------------------
Deltamir - *ITN Security Expert, DevSecOps Engineer and Certified Pentester in a Telecom company*  
Contact via Github inbox

Other
------------------
The CI of this project is handled here on [Gitlab](https://gitlab.com/Deltamir/ansible-hashistack)  
This project patch management is handled by a Renovate Bot on Gitlab  
This project is mirrored here on [Github](https://github.com/Deltamir/ansible-hashistack/)