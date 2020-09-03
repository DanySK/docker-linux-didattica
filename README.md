# Manjaro Linux virtual machine for teaching

I'm tired of stuff not working with Windows and dual boots are apparently not a thing in my university,
VMs drain too many resources,
some students have Linux/Mac PCS...
So I adopted docker

## Run on linux

```bash
docker pull danysk/linux-didattica
docker run --rm --net=host --env="DISPLAY" -v <WHERE_TO_LOCALLY_PERSIST>:/home/user --volume="$HOME/.Xauthority:/.Xauthority:rw" -it danysk/linux-didattica
```

## Run on Windows 10

Install [VcXsrv](https://sourceforge.net/projects/vcxsrv/), configure it as explained [here](https://archive.vn/qPC6F).

On a cmd/powershell run `ipconfig` and find your IP address.
```bash
docker pull danysk/linux-didattica
set-variable -name DISPLAY -value <YOUR_IP>:0.0
docker run --rm <WHERE_TO_LOCALLY_PERSIST>:/home/user -e DISPLAY=$DISPLAY -it danysk/linux-didattica
```

## Run on Mac OS X

TBD
