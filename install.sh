#! /bin/bash -e

if [[ ${PWD##*/} != 'boot' ]]; then
	echo 'Current directory is not /boot!'
fi

if [[ ! -f config.txt ]]; then
	echo 'File config.txt missing'
fi

read -rp "Enter pi user password: " PASS

# hash password
PASS="$(echo -n "$PASS" | /opt/homebrew/opt/openssl/bin/openssl passwd -6 -stdin)"

# set default user/pass
echo "pi:${PASS}" > userconf.txt

# enable digione DAC
echo 'dtoverlay=allo-digione' >> config.txt

# setup sshd
touch ssh

read -rp "Enter bacon wifi password: " PSK

# hash password
PSK="$(echo -n "$PSK" | iconv -t UTF-16LE | openssl md4)"

# setup wifi
tee wpa_supplicant.conf > /dev/null <<EOF
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=AU

network={
  ssid="bacon"
  psk="hash:${PSK}"
}
EOF
