#! /bin/bash -e

if [[ ! -f config.txt ]]; then
	echo 'File config.txt missing from current directory!'
fi

# enable digione DAC
echo 'dtoverlay=allo-digione' >> config.txt

# setup sshd
touch ssh

read -rp "Enter bacon wifi password: " PSK

# setup wifi
tee wpa_supplicant.conf > /dev/null <<EOF
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=AU

network={
  ssid="bacon"
  psk="${PSK}"
}
EOF
