# Project 9 - Createing Honeypots

Time spent: **27** hours spent in total

> Objective: Create multiple honeypots and monitor the activity.

## Approach, resources/tools used, findings
- On the Ubuntu 14.04 installed Google Cloud SDK and connected to my account:  
```bash
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
gcloud init
```
- Afre running ```gcloud init``` select defalut region and zone to be ```us-central1``` and ```us-central1-c```
- Created a firewall rule to allow trafic on ports 3000 and 10000
<img src="./img/firewall_rule.png" /><br />
<img src="./img/firewall_rule1.png" /><br />
```bash
