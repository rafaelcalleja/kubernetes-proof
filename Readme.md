# Jenkins Machine Setup
### Install Python 3, Ansible, and the openshift module 
sudo apt update && sudo apt install -y python3 && sudo apt install -y python3-pip && sudo pip3 install ansible && sudo pip3 install openshift

ansible-galaxy install geerlingguy.jenkins

ansible-galaxy install geerlingguy.docker

##### playbook.yaml

https://github.com/geerlingguy/ansible-role-jenkins

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

https://cloud.google.com/solutions/continuous-delivery-jenkins-kubernetes-engine?hl=es-419
https://cloud.google.com/solutions/jenkins-on-kubernetes-engine-tutorial?hl=es-419
https://developer.ibm.com/tutorials/use-jenkins-and-istio-for-canary-deployment/
https://blog.csanchez.org/2019/03/05/progressive-delivery-with-jenkins-x-automatic-canary-deployments/

