# Docker

## Centos 9
> https://docs.docker.com/engine/install/centos/
### Install CentOS 9 (Install using the rpm repository)
> The centos-extras repository must be enabled. 
> This repository is enabled by default. 
> If you have disabled it, you need to re-enable it.
> Before you can install Docker Engine, you need to uninstall any conflicting packages.
```html
dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
dnf remove <package_name>
```
> Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository. 
> Afterward, you can install and update Docker from the repository.
```commandline
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf remove <package_name>
```
```doctest
test
# sudo dnf -y install dnf-plugins-core
$ sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf remove <package_name>
```
```dtd
test
# sudo dnf -y install dnf-plugins-core
$ sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf remove <package_name>
```