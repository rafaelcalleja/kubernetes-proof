# Jenkins Machine Setup
### Install Python 3, Ansible, and the openshift module 
sudo apt update && sudo apt install -y python3 && sudo apt install -y python3-pip && sudo pip3 install ansible && sudo pip3 install openshift

ansible-galaxy install geerlingguy.jenkins

ansible-galaxy install geerlingguy.docker

##### playbook.yaml

```yaml
- hosts: localhost
  become: yes
  vars:
    jenkins_hostname: 35.238.224.64
    docker_users:
    - jenkins
  roles:
    - role: geerlingguy.jenkins
    - role: geerlingguy.docker
```


