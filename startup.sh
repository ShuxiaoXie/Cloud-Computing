#!/bin/bash 

apt-get update -y
apt-get upgrade -y
apt-get install -y python3-pip
pip3 install --upgrade flask

# down the app code
wget -P templates http://storm.cis.fordham.edu/ji/cisc5550/demo/templates/index.html
wget http://storm.cis.fordham.edu/ji/cisc5550/demo/todolist.py
wget http://storm.cis.fordham.edu/ji/cisc5550/demo/todolist.db

python3 todolist.py
