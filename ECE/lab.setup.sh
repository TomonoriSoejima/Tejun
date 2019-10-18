
# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh


sudo usermod -aG docker $USER
sudo chmod 777 /mnt

sudo systemctl stop firewalld
sudo service docker restart


# to deal with the error below
# follow https://stackoverflow.com/questions/42889241/how-to-increase-vm-max-map-count

# Checking OS max map count setting... FAILED
#  OS setting 'vm.max_map_count' should be >= 262144, currently 65530

# finally this should work!
 bash <(curl -fsSL https://download.elastic.co/cloud/elastic-cloud-enterprise.sh) install
