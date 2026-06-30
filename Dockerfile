FROM ghcr.io/blakeblackshear/frigate:stable

# Copy our customized API files
COPY app.py /opt/frigate/frigate/api/app.py

LABEL maintainer="SMS Services Karachi"
LABEL description="SMS Sentinel AI — Custom Frigate NVR"
LABEL version="0.17.1-sms"
