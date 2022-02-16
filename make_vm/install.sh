
sudo yum install -y go
sudo yum install -y make


# https://github.com/elastic/terraform-provider-ec test
mkdir -p ~/development; cd ~/development
git clone https://github.com/elastic/terraform-provider-ec
cd terraform-provider-ec
make install
