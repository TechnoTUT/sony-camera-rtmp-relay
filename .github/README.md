# Sony-Camera-RTMP-Relay
This is containers for Sony Camera RTMP Relay. We use it for DJ Production.  
We are running this container on a k3s cluster. For more information on operating with Kubernetes, see [TechnoTUT/k3s](https://github.com/TechnoTUT/k3s).

## Special Thanks
Thanks to ma1co/OpenMemories and the following issues for giving us the knowledge.  
https://github.com/ma1co/OpenMemories-Tweak/issues/224

## Supported Cameras
Sony HDR-CX680  
Other cameras might work.

## How to use
### 1. Install Sony-PMCA-RE
You prepare Windows PC and install Sony-PMCA-RE.  
Download from https://github.com/ma1co/Sony-PMCA-RE/releases  

### 2. Write "fake credentials" to your camera
Download `stream.cfg` and write the file to the camera using Sony-PMCA-RE.  
You can use the following command to write the file to the camera.
```powershell
curl https://raw.githubusercontent.com/TechnoTUT/sony-camera-rtmp-relay/refs/heads/main/stream.cfg -o stream.cfg
pmca-console-v0.18-win.exe stream -w stream.cfg
```
### 3. Configure your network
Configure your DHCP server.
Change the DNS server address to the server's IP address.

### 4. Clone this repository
```bash
git clone https://github.com/technotut/sony-camera-rtmp-relay.git && cd sony-camera-rtmp-relay
```

### 5. Change container settings
Change the `docker-compose.yml` and `dns/Corefile` file to match your network settings.
After changing the settings, you need to rebuild the image.
```bash
docker-compose build
```

### 6. Start the containers
```bash
docker-compose up -d
```
If you don't use the default port, you need to change the port in the `docker-compose.yml` file.
Also, you need to change the stream IP address (nginx container address) and upstream dns server address in the `docker-compose.yml` file.  
Stream server IP address is hardcoded in the `nginx.conf` file. If you change the IP address, you need to change the `nginx.conf` file. Please rebuild the image or mount the `nginx.conf` file to the container.  

You want local streaming server, you can use [TechnoTUT/rtmp-live-server](https://github.com/TechnoTUT/rtmp-live-server).

If you want to stop the containers, you can use the following command.
```bash
docker-compose down
```

### 7. Start streaming
Start streaming from your camera.  
If you use [TechnoTUT/rtmp-live-server](https://github.com/TechnoTUT/rtmp-live-server), you can check the streaming status by accessing the `http://<rtmp-live-server_IPaddress>/stat`.  

### Optional: Use Podman
If you are using Red Hat Enterprise Linux (or RHEL clones such as Alma Linux or Rocky Linux) and want to use this repository, you may want to work with Podman.  
To make it work with Podman, do the following:  
```bash
## Install Podman, pip, and git
sudo dnf install -y podman podman-plugins python3-pip git
## Install podman-compose
## ## If you added EPEL repository, you can use "sudo dnf install -y podman-compose" instead of the following command. 
pip3 install podman-compose 
## Clone this repository
git clone https://github.com/technotut/sony-camera-rtmp-relay.git && cd sony-camera-rtmp-relay
## Change the container settings
## ## Change the "docker-compose.yml" and "dns/Corefile" file to match your network settings.
## ## After changing the settings, you need to rebuild the image.
vi docker-compose.yml
vi dns/Corefile
podman-compose build
## Start the containers
podman-compose up -d
```
If you want to automatically start the containers when the system starts, you can use the following command.
```bash
## Enable linger for the user
## Replace <username> with your username
sudo loginctl enable-linger <username>
## Generate a systemd service file
podman-compose systemd -a create-unit
## Create service files and paste the generated service file
sudo vi /etc/systemd/user/podman-compose\@.service
## Enable and start the service
systemctl --user enable --now podman-compose@
```
For more information on podman-compose and systemd, please refer to the following links:  
https://www.it-hure.de/2024/02/podman-compose-and-systemd/
