.PHONY: install
install: clean
	@bash install.sh

.PHONY: clean
clean:
	rm -f wpa_supplicant.conf userconf.txt config.txt ssh
