@echo off
echo SMS Sentinel AI - Custom Frigate NVR Installer
mkdir "%USERPROFILE%\frigate-sms\config" 2>nul
mkdir "%USERPROFILE%\frigate-sms\recordings" 2>nul
docker stop frigate 2>nul
docker rm frigate 2>nul
docker pull toadnan/sms-frigate:latest
docker run -d --name frigate --restart unless-stopped -p 5000:5000 -p 8971:8971 -p 8554:8554 -p 8555:8555 -p 1935:1935 -p 1984:1984 -v "%USERPROFILE%\frigate-sms\config:/config" -v "%USERPROFILE%\frigate-sms\recordings:/media/frigate" toadnan/sms-frigate:latest
echo Done! Open http://localhost:5000
pause
