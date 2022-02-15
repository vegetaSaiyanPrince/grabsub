#!/bin/bash
BLUE='\033[94m'

RED='\033[91m'

GREEN='\033[92m'

ORANGE='\033[93m'

RESET='\e[0m'

status="install ok installed"

jq=$(dpkg-query -W --showformat='${Status}\n' jq | grep "install ok installed")
if [ "$status" == "$jq" ]; then
    echo -e "$GREEN [+]jq - requirement already satisfied $RESET"
else
    sudo apt install jq
fi

sublister=$(dpkg-query -W --showformat='${Status}\n' sublist3r | grep "install ok installed")
if [ "$status" == "$sublister" ]; then
    echo -e "$GREEN [+]sublist3r - requirement already satisfied $RESET"
else
    sudo apt install sublist3r
    sudo ln -s /usr/bin/python3 /usr/bin/python
fi

golang=$(dpkg-query -W --showformat='${Status}\n' golang-go | grep "install ok installed")
if [ "$status" == "$golang" ]; then
    echo -e "$GREEN [+]golang - requirement already satisfied $RESET"
else
    sudo apt install golang-go
fi

mkdir tools/httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
cp $HOME/go/bin/httpx tools/httpx/
chmod +x tools/httpx/httpx

mkdir tools/subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
cp $HOME/go/bin/subfinder tools/subfinder/
chmod +x tools/subfinder/subfinder

mkdir tools/assetfinder
go install -v github.com/tomnomnom/assetfinder@latest
cp $HOME/go/bin/assetfinder tools/assetfinder/
chmod +x tools/assetfinder/assetfinder