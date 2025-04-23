#! /bin/bash -e

if [[ -d /Volumes/boot ]]; then
	cd /Volumes/boot
elif [[ -d /Volumes/bootfs ]]; then 
	cd /Volumes/bootfs
else
	echo 'Raspberry boot volume not mounted'
	exit 1
fi

if [[ ! -f config.txt ]]; then
	echo 'File config.txt missing'
fi

read -rp "Enter pi user password: " PASS

# hash password
PASS="$(echo -n "$PASS" | /opt/homebrew/opt/openssl/bin/openssl passwd -6 -stdin)"

# set default user/pass
echo "pi:${PASS}" > userconf.txt
echo 'Written /boot/userconf.conf'

# setup sshd
touch ssh
echo 'Created /boot/ssh'

read -rp "Which SSID? 1. bacon, 2. eggs_iot " SSID

if [[ $SSID -eq 1 ]]; then
	SSID='bacon'
	PSK='7edb78e26f73b7b2bc9a401f3c8abdea6d2ee193c78f6e92335061c7b6fdb655'
elif [[ $SSID -eq 2 ]]; then
	SSID='eggs_iot'
	PSK='8d0b47dc934183b58e86cb42599fe0979e2165cd78b5f2d9379bbae5d50e47db'
else
	echo 'Invalid choice, you lose'
	exit 44
fi

# setup wpa_supplicant
tee wpa_supplicant.conf > /dev/null <<EOF
ctrl_interface=/run/wpa_supplicant
country=AU

network={
  ssid="${SSID}"
  psk=${PSK}
}
EOF

echo 'Written /boot/wpa_supplicant.conf'
