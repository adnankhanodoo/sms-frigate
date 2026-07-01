#!/bin/bash
echo "🚀 Installing SMS Sentinel AI — Custom Frigate NVR..."

mkdir -p ~/frigate-sms/config
mkdir -p ~/frigate-sms/recordings

cat > ~/frigate-sms/config/config.yaml << 'CONFIG'
mqtt:
  enabled: false
auth:
  enabled: true
  session_length: 604800
  roles:
    gate_viewer:
      - gate
    tower_operator:
      - cam242
      - cam243
cameras: {}
version: 0.17-0
CONFIG

docker stop frigate 2>/dev/null
docker rm frigate 2>/dev/null

docker pull toadnan/sms-frigate:latest

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
sleep 25

echo ""
echo "✅ SMS Sentinel AI Frigate installed!"
echo "🌐 UI (no auth):     http://localhost:5000"
echo "🔐 UI (auth):        https://localhost:8971"
echo ""
echo "🔑 Get admin password:"
echo "   docker logs frigate 2>&1 | grep -i password | tail -3"
echo ""
echo "📷 Add camera:"
echo "   curl -X POST http://localhost:5000/api/cameras/add \\"
echo "     -H 'Content-Type: application/json' \\"
echo "     -d '{\"name\": \"cam1\", \"ip\": \"192.168.1.100\", \"username\": \"admin\", \"password\": \"pass\", \"brand\": \"hikvision\", \"channel\": 1}'"
