#!/bin/bash
################ Description: ###################
# Go installation script.
################ Parameter: #####################
# None
################ Implementation: ################
clear
testFile='test.go'
logFile='test.log'
testString='Hello World!'
testFileContent='package main
import "fmt"

func main() {
	fmt.Println("Hello World!")
}
'

if test `id -u` -ne 0
then
  echo -e "[-] Missing privileges..."
  exit 1
fi

# Installation
cd /tmp/
echo "[*] Downloading Go..."
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz >/dev/null 2>&1
echo "[*] Untar Go..."
tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz >/dev/null 2>&1
echo "[*] Setting interpreter path"
export PATH=$PATH:/usr/local/go/bin

# Testing:
echo "[*] Testing Go-installation.."
touch $testFile && echo "$testFileContent" > $testFile && go run $testFile > $logFile

testReturn=`cat test.log`
rm -f $testFile $logFile

if test "$testReturn" == "$testString"
then
    echo "[+] Go-installation successfully installed."
    exit 0
else
    echo "[-] Go-installation failed."
    exit -1
fi