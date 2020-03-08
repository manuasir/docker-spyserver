### Dockerized RTL Spyserver for Raspberry Pi

Install and configure a containerized RTL Spyserver using Docker in your Raspberry Pi.

#### Instructions

1. It's needed to block certain kernel modules to get the RTL-SDR device work properly. Place the `blacklist-rtl.conf` file into your host `/lib/modprobe.d/` folder:
```
cp ./files/blacklist-rtl.conf /lib/modprobe.d/
```

2. Additionally, we need to set the correct permissions to the modules in order to allow TCP messages. Place the `rtl_sdr.rules` file into your host `/etc/udev/rules.d/` folder:
```
cp ./files/rtl_sdr.rules /etc/udev/rules.d/
```

3. Reboot your Raspberry Pi, this action should only be done once.

4. Run the container using the `docker-compose` file included here:
```
version: "3.7"
services:
  spyserver:
    build: .
    ports:
     - "5555:5555"
    privileged: true
    volumes:
      - /dev/bus/usb:/dev/bus/usb

```

```
docker-compose up -d --build spyserver
```

5. The container will listen requests on `5555` port, connect to it using your RTL-SDR client (i.e. SDRSharp) and point to the IP of the Raspberry device.
```
sdr://<raspberry-ip>:55000
```

6. Enjoy it and open an issue or collaborate with a PR if anything is not working as expected.
