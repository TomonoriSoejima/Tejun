
# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh


sudo usermod -aG docker $USER
sudo chmod 777 /mnt

sudo systemctl stop firewalld
sudo service docker restart
