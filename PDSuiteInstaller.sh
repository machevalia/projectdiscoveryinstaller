#!/usr/bin/env bash

printf "I love\n"
printf " _                        _\n"
printf "|_) ._  _   o  _   _ _|_ | \ o  _  _  _      _  ._ \n"
printf "|   |  (_)  | (/_ (_  |_ |_/ | _> (_ (_) \/ (/_ |  \/ \n"
printf "           _|                                      /\n"
printf "by @machevalia\n"


read -n 1 -p "What shell are you using? zsh or bash? (z/b) " opt;

if [[ "$opt" == *"z"* ]]; then
        shell=.zshrc
elif [[ "$opt" == *"b"* ]]; then
        shell=.bashrc
fi
printf "\n\n"
printf "Shell is now equal to $shell\n\n"

if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

#Install golang:
version=$(curl -L -s https://golang.org/VERSION?m=text)
printf "Installing/Updating Golang\n\n"

if [[ $(eval type go $DEBUG_ERROR | grep -o 'go is') == "go is" ]] && [ "$version" = $(go version | cut -d " " -f3) ]
    then
        printf "Golang is already installed and updated\n\n"
    else 
        eval wget https://dl.google.com/go/${version}.linux-amd64.tar.gz
        eval tar -C /usr/local -xzf ${version}.linux-amd64.tar.gz
fi
        eval ln -sf /usr/local/go/bin/go /usr/local/bin/
    rm -rf $version*


cat << EOF >> ~/${profile_shell}/$shell 

# Golang vars
export GOROOT=/usr/local/go
export GOPATH=\$HOME/go
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$HOME/.local/bin:\$PATH
EOF



#Installing PD Tools
printf "Installing Nuclei\n\n"
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest > /dev/null

printf "Installing Subfinder\n\n"
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest > /dev/null

printf "Installing Naabu\n\n"
sudo apt install -y libpcap-dev >/dev/null 2>&1
go install -v  github.com/projectdiscovery/naabu/v2/cmd/naabu@latest > /dev/null

printf "Installing Interactsh\n\n"
go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest > /dev/null

printf "Installing Httpx\n\n"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest > /dev/null

printf "Installing Dnsx\n\n"
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest > /dev/null

printf "Installing ShuffleDNS\n\n"
go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest > /dev/null

printf "Installing notify\n\n"
go install -v github.com/projectdiscovery/notify/cmd/notify@latest > /dev/null

printf "Installing mapcidr\n\n"
go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest > /dev/null


printf "Done installing.\n\nRun 'source ~/.zshrc' or 'source ~/.bashrc' to pick up your new Golang environmental variables if needed. Enjoy!"
