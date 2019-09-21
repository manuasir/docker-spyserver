#!/bin/bash

configure(){
    sed -i '/.*device_type*/c\device_type = RTL-SDR' /spyserver.config && \
    sed -i '/.*device_sample_rate*/c\device_sample_rate = 2048000' /spyserver.config && \
    sed -i '/.*fft_fps*/c\fft_fps = 10' /spyserver.config && \
    sed -i '/.*initial_gain*/c\initial_gain = 20' /spyserver.config
}

start_service(){
    /spyserver
}

main(){
    configure
    start_service
}

main