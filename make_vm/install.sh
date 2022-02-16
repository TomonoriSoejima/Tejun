
sudo yum install -y go
sudo yum install -y make
sudo yum install -y git

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

# https://github.com/elastic/terraform-provider-ec test
mkdir -p ~/development; cd ~/development
git clone https://github.com/elastic/terraform-provider-ec
cd terraform-provider-ec
sudo make install



git version
go version
terraform version
