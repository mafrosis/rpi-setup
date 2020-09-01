Allo Digione
============

How to setup the [Allo Digione](https://www.allo.com/sparky/digione.html).


## Quickstart

First mount the `/boot` partition of the SD card and `cd` into it.

Setup SSH, wifi and enable the overlay for the Allo Digione:

    ./install.sh


## Vendor Doco

Allo Digione is a high-quality S/PDIF output board for the Raspberry Pi. The S/PDIF interface chip
supports up to 192kHz/24bit resolution with dual low-jitter oscillators.

- Device: Allo Digione
- Chip: WM8805
- Interface: I2S
- Sampling rate: 32 kHz to 192 kHz sampling freq
- Data bit length: 16 to 24-bit

### Device driver

    snd-soc-allo-digione.ko

### Device tree overlay

    dtoverlay=allo-digione

### ALSA card name

    card 0: sndallodigione [snd_allo_digione], device 0: Allo DigiOne HiFi wm8804-spdif-0 []
