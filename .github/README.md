# Sony-Camera-RTMP-Relay
This is containers for Sony Camera RTMP Relay.  

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
create a file named `stream.cfg` with the following content:
```
[
    [
        "twitterEnabled",
        0
    ],
    [
        "twitterConsumerKey",
        ""
    ],
    [
        "twitterConsumerSecret",
        ""
    ],
    [
        "twitterAccessToken1",
        ""
    ],
    [
        "twitterAccessTokenSecret",
        ""
    ],
    [
        "twitterMessage",
        "Live Streaming from Handycam by Sony"
    ],
    [
        "facebookEnabled",
        0
    ],
    [
        "facebookAccessToken",
        ""
    ],
    [
        "facebookMessage",
        "Live Streaming from Handycam by Sony"
    ],
    [
        "service",
        0
    ],
    [
        "enabled",
        1
    ],
    [
        "macId",
        "1234567890123456789012345678901234567890"
    ],
    [
        "macSecret",
        "123456789012345678901234567890123467890"
    ],
    [
        "macIssueTime",
		"a9315a5f00000000"
    ],
    [
        "unknown",
        1
    ],
    [
        "channels",
        [
            12345678
        ]
    ],
    [
        "shortURL",
        "http://ustre.am/1AAAA"
    ],
    [
        "videoFormat",
        3
    ],
    [
        "supportedFormats",
        [
            1,
            3
        ]
    ],
    [
        "enableRecordMode",
        0
    ],
    [
        "videoTitle",
        "Test"
    ],
    [
        "videoDescription",
        "Test"
    ],
    [
        "videoTag",
        "Test"
    ]
]
```
Write the file to the camera using Sony-PMCA-RE.  
You can use the following command to write the file to the camera.
```powershell
pmca-console-v0.18-win.exe stream -w stream.cfg
```
### 3. Configure your network
Configure your DHCP server to change the DNS server to the IP address of the dns container.  

### 4. Start the containers
```bash
git clone https://github.com/technotut/sony-camera-rtmp-relay.git && cd sony-camera-rtmp-relay
docker-compose up -d
```
If you don't use the default port, you need to change the port in the `docker-compose.yml` file.
Also, you need to change the stream IP address (nginx container address) and upstream dns server address in the `docker-compose.yml` file.  
Stream server IP address is hardcoded in the `nginx.conf` file. If you change the IP address, you need to change the `nginx.conf` file. Please rebuild the image or mount the `nginx.conf` file to the container.  

You want local streaming server, you can use [TechnoTUT/rtmp-live-server](https://github.com/TechnoTUT/rtmp-live-server).

### 5. Start streaming
Start streaming from your camera.  
You can check the streaming status by accessing the `http://<nginx-container_IPaddress>/stat`