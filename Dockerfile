FROM arm32v7/ubuntu

# Install dependencies
RUN apt-get update && apt-get install wget git cmake pkg-config libusb-1.0-0-dev gcc -y

# Get driver repository
RUN git clone git://git.osmocom.org/rtl-sdr.git

# Compile drivers
RUN cd rtl-sdr && \
        mkdir build && \
        cd build && \
        cmake ../ -DINSTALL_UDEV_RULES=ON && \
        make && \
        make install && \
        ldconfig

RUN mkdir spyserver

RUN wget https://airspy.com/downloads/spyserver-arm32.tgz && tar zxvf spyserver-arm32.tgz && tar zxvf spyserver-arm32.tgz 

COPY ./entrypoint.sh /

RUN chmod a+x /entrypoint.sh

# Execute RTL server
ENTRYPOINT ["/entrypoint.sh"]
