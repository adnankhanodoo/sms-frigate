#!/bin/bash
echo "🚀 Installing SMS Sentinel AI — Custom Frigate NVR..."

# Create directories
mkdir -p ~/frigate-sms/config
mkdir -p ~/frigate-sms/recordings

# Create default config
cat > ~/frigate-sms/config/config.yaml << 'CONFIG'
mqtt:
  enabled: false
cameras: {}
version: 0.17-0
CONFIG

# Stop existing frigate if running
docker stop frigate 2>/dev/null
docker rm frigate 2>/dev/null

# Pull and run
docker run -d \
  --name frigate \
  --restart unless-stopped \
  --privileged \
  -p 5000:5000 \
  -p 8971:8971 \
  -p 8554-8555:8554-8555 \
  -p 1935:1935 \
  -p 1984:1984 \
  -p 8555:8555/udp \
  -v ~/frigate-sms/config:/config \
  -v ~/frigate-sms/recordings:/media/frigate \
  --device /dev/dri:/dev/dri \
  toadnan/sms-frigate:latest

echo "⏳ Waiting for Frigate to start..."
sleep 20

echo "✅ SMS Sentinel AI Frigate installed!"
echo "🌐 Open browser: http://localhost:5000"
echo "📷 Add camera: POST http://localhost:5000/api/cameras/add"
