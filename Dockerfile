# Try switching to nodesource/xenial if Ubuntu retire the ubuntu:xenial image.
FROM ubuntu:xenial

ARG uid
ARG workspace

# Required to stop things like `tzdata` asking for your timezone.
ARG DEBIAN_FRONTEND=noninteractive

RUN useradd --uid $uid worker --create-home \
    && mkdir $workspace \
    && chown $uid $workspace \
    && apt-get update \
    && apt-get dist-upgrade --yes \
    && apt-get install --yes luminance-hdr python3-venv python3-pip python3-tk x11vnc xvfb openbox hugin-tools

WORKDIR $workspace

# Start a minimal window manager (so windows can be moved etc.) but don't bother starting a desktop environment.
ENV FD_PROG=/usr/bin/openbox

# By default x11vnc will use display number 20 - change it to 0.
ENV X11VNC_CREATE_STARTING_DISPLAY_NUMBER=0
ENV DISPLAY=:0

CMD ./startup
