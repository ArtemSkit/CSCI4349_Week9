# Project 9 - Createing Honeypots

Time spent: **27** hours spent in total

> Objective: Create multiple honeypots and monitor the activity.

## Approach, resources/tools used, findings
Following the CodePath tutorial I created the mhn-admin VM and mhn-honepot VM.  
I used https://github.com/RedolentSun/mhn.git GitHub project to create the honeypot network.  
I run the following script in the honepot VMs:
- mhn-honeypot&nbsp;&nbsp;&nbsp;&nbsp;= Ubuntu - Snort
- mhn-honeypot-1 = Ubuntu - Dionaea with HTTP
- mhn-honeypot-2 = Ubuntu - p0f
- mhn-honeypot-3 = Ubuntu - Kippo as vulnerable Juniper Netscreen
- mhn-honeypot-4 = Ubuntu - Suricata
- mhn-honeypot-5 = Ubuntu - Dionaea
- mhn-honeypot-6 = Ubuntu - Amun

After running mhn-honeypot-3 instance for about 15 hours, I found out that I can no longer ssh into the VM.<br />  
<img src="./img/ssh.PNG" /><br />  
Most likely the instance was compromised.

## Reproducible honeypot setup
### Requirements
- OS: Ubuntu 14.04 (trusty)
- Cores: 1vCPU
- CPU platform: Intel Haswell
- Memory: 0.6 GB
- GCP VM Zone: us-central1-c
- Allowed Traffic: For admin VM - HTTP, HTTPS, SSH; For honeypot VM - all ports and all protocols
- At least two VMs - one is a honeypot, another is the hub that collects malware and logs
### Features
- The server running Modern Honey Network provides information about scan attemps, their time, IP, and geografical location.<br />
<img src="./img/Attacks.PNG" /><br />  
- Aditionaly it stores the payloads attempted to be uploaded and run on honeypot servers.
<img src="./img/Payloads.PNG" /><br />  
### Steps to setup
- On the Ubuntu 14.04 installed Google Cloud SDK and connected to my account:  
```bash
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
gcloud init
```
- After running ```gcloud init``` select defalut region and zone to be ```us-central1``` and ```us-central1-c```<br />
- Created a firewall rule to allow trafic on ports 3000 and 10000<br />
<img src="./img/firewall_rule.PNG" />
<img src="./img/firewall_rule1.PNG" />
- Create admin server and ssh into it
<img src="./img/create_admin_server_from_shell.PNG" />
<img src="./img/ssh_to_admin_server.PNG" /><br />  
My ssh key setup:<br />
```text
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:Texas
Locality Name (eg, city) []:San Antonio
Organization Name (eg, company) [Internet Widgits Pty Ltd]:week9
Organizational Unit Name (eg, section) []:art
Common Name (e.g. server FQDN or YOUR name) []:35.202.171.224
Email Address []:bigbossofgarena@gmail.com
```
- Make mhn-admin VM ip static
<img src="./img/admin_ip.PNG" /><br />  
- Run the following commands from the admin VM shell:
    ```bash
    sudo apt-get update
    sudo apt-get install git -y
    cd /opt
    sudo git clone https://github.com/RedolentSun/mhn.git
    cd mhn
    cd scripts/
    sudo nano ./install_hpfeeds.sh
    ```
    Change the line  
    ```pip install -e git+https://github.com/HurricaneLabs/pyev.git#egg=pyev```  
    to  
    ```pip install -e git+https://github.com/couozu/pyev.git#egg=pyev```  
    save it and run the install script in mhn folder
    ```bash
    cd ../
    $ sudo ./install.sh
    ```
- Create honepot VM and ssh into it<br />  
<img src="./img/create_honeypot_server_from_shell.PNG" />
<img src="./img/ssh_to_honeypot.PNG" /><br />  
- In the admin server web interface click deploy
- Select script
<img src="./img/honeypot_script.PNG" />
- Copy the command and run it in the honepot instance shell
- After some time you will have some traffic logs display in the admin server web interface Attacks tab