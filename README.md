# installer
Pistation Installer


## Raspberry Pi 2
### You need:
- Raspberry Pi 2
- MicroSD Card
- An ethernet cable connection OR a wificard, keyboard and monitor. In the case of the ethernet you can check your router for the IP of the RPI, and connect remotely using ``ssh pi@192.168.xxx.xxx`` and password ``raspberry``. Otherwise you'll need to run it manually on the RPI itself.

### How to install:
- Install Raspbian (We've used Rapsian Jessie Lite - read more on how to do a clean install on your Pi on this page: https://www.raspberrypi.org/downloads/raspbian/)
- Once in the main terminal of the RPI, run the following script: ``curl -s https://raw.githubusercontent.com/PiStation/installer/master/install.sh|sh``
- This downloads the script and executes it. You might want to manually do a double check on the installation script - just to be sure.
