#!/bin/bash
echo "Enter domain name"
read domain
sudo mkdir $domain
cd $domain
echo "Using Knockpy.............................................................."
sudo knockpy $domain --no-http-code 404 500 530 -th 200
echo "Using subfinder............................................................"
sudo subfinder -d $domain -o subfinder1.txt
sudo subfinder -d $domain -o subfinder2.txt
sudo cat subfinder1.txt subfinder2.txt | sudo tee -a  subfinder.txt
sudo rm subfinder1.txt subfinder2.txt
echo "Using gau.................................................................."
sudo gau --subs $domain | unfurl domains | sort -u | sudo tee -a gau.txt
sudo gau --subs $domain | unfurl domains | sort -u | sudo tee -a gau.txt
echo "Using waybackurls.........................................................."
sudo waybackurls $domain | unfurl domains | sort -u | sudo tee -a waybackurls.txt
sudo waybackurls $domain | unfurl domains | sort -u | sudo tee -a waybackurls.txt
echo "Using assetfinder.........................................................."
sudo assetfinder $domain -subs-only | grep "\.$domain" | sudo tee -a assetfinder.txt 
sudo assetfinder $domain -subs-only | grep "\.$domain" | sudo tee -a assetfinder.txt
echo "Using amass................................................................"
sudo cp ../../../config.ini config.ini
sudo amass enum -d $domain -config config.ini | sudo tee -a amass.txt
sudo amass enum -d $domain | sudo tee -a amass.txt
sudo cat subfinder.txt gau.txt waybackurls.txt assetfinder.txt amass.txt | sort -u | sudo tee -a final1.txt
