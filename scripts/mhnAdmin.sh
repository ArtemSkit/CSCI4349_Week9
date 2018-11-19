#!/bin/bash
# Run this script from mhn-admin VM shell
sudo apt-get install git -y

cd /opt
sudo git clone https://github.com/RedolentSun/mhn.git
cd mhn
cd scripts/

# Change the line  
#     ```pip install -e git+https://github.com/HurricaneLabs/pyev.git#egg=pyev```  
#     to  
#     ```pip install -e git+https://github.com/couozu/pyev.git#egg=pyev```
ex -s -c '%s/HurricaneLabs/couozu/g|x' install_hpfeeds.sh
cd ../

sudo ./install.sh