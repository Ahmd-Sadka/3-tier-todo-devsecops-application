Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. host# Docker Role
## Role Name
docker
## Description
This role installs and configures Docker and Docker Compose on a target server, tailored for Amazon Linux 2 (with support for other Red Hat-based systems). It ensures Docker is running, enables it on boot, and optionally adds users to the Docker group for non-root access.

## Requirements
- Ansible 2.9 or higher.
- Internet access to download Docker packages.
- Root privileges (`become: yes`).

## Role Variables
### `defaults/main.yml`
- `docker_packages`: List of packages to install (default: `["docker", "docker-compose"]`).
- `docker_service`: Name of the Docker service (default: `"docker"`).
- `docker_users`: List of users to add to the Docker group (default: `[]`).

## Example Playbook
```yaml
- hosts: pipeline_server
  roles:
    - role: docker
      vars:
        docker_users:
          - ec2-uservars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

