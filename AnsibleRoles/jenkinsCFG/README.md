jenkins_setup
-------------

This role automates the installation and configuration of a Jenkins server on a pipeline server, specifically tailored for Amazon Linux 2 (with support for other Red Hat-based systems). It performs the following tasks:

- Installs Java 11 (using `amazon-linux-extras` for Amazon Linux or standard package managers for other systems).
- Installs Git and Jenkins using the official Jenkins repository.
- Configures Jenkins by unlocking it, setting up an admin user, and completing the setup wizard.
- Installs specified Jenkins plugins and sets up GitHub credentials for repository access.
- Generates a Jenkins API token for secure automation.
- Uses Ansible Vault to securely manage sensitive data like admin passwords and GitHub credentials.

This role is ideal for setting up a Jenkins server as part of a CI/CD pipeline, such as for an EKS cluster environment with tools like ArgoCD, Prometheus, and SonarQube.

Requirements
------------

- **Ansible Version**: Ansible 2.9 or higher is required.
- **Community.General Collection**: This role uses the `community.general.jenkins_script` and `community.general.jenkins_plugin` modules. Install the collection with:
  ```bash
  ansible-galaxy collection install community.general

Role Variables
--------------

Variables in defaults/main.yml
jenkins_user: The username for the Jenkins admin user.
Default: "admin"
java_packages: The Java package to install.
Default: "java-11-openjdk" for non-Amazon Linux systems; Amazon Linux uses amazon-linux-extras install java-openjdk11.
jenkins_packages: The Jenkins package to install.
Default: "jenkins"
jenkins_port: The port Jenkins will run on.
Default: 8080
jenkins_initial_password_file: The path to Jenkins’ initial admin password file.
Default: /var/lib/jenkins/secrets/initialAdminPassword
jenkins_plugins: A list of Jenkins plugins to install.
Default: Not set; must be provided (e.g., ["git", "pipeline"]).
github_credentials: A dictionary containing GitHub credentials for Jenkins to access repositories.
Default:

Variables in vault.yml (Encrypted)
Sensitive variables must be stored in vault.yml (e.g., secrets/vault.yml) and encrypted with Ansible Vault: $ ansible-vault encrypt secrets/vault.yml
jenkins_admin_password: The password for the Jenkins admin user.
credentials: A dictionary containing GitHub credentials for Jenkins to access repositories.


Dependencies
------------

This role has no dependencies on other Ansible roles from Galaxy. However, it relies on:

The community.general collection for Jenkins-related modules.
A vault.yml file containing encrypted sensitive data.



License
-------

BSD

Author Information
------------------


