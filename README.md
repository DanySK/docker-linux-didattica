# Manjaro Linux virtual machine for teaching

I'm tired of stuff not working with Windows and dual boots are apparently not a thing in my university,
VMs drain too many resources,
some students have Linux/Mac PCS...
So I adopted docker

* Link to the [docker hub page](https://hub.docker.com/repository/docker/danysk/docker-linux-didattica)
* Quickly pull it via: `docker pull danysk/docker-linux-didattica:latest`

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
docker run --rm "<WHERE_TO_LOCALLY_PERSIST>:/home/user" --volume="$HOME/.Xauthority:/.Xauthority:rw" -e DISPLAY=$DISPLAY -it danysk/linux-didattica
```

### Import as a WSL2 distro

* Download the `*.tar.zstd.*` files from [the release page](https://github.com/DanySK/docker-linux-didattica/releases)
* Join them back into a single compressed archive:
  * Bash: `cat *.tar.zstd.* > wsl.tar.zstd`
  * Cmd: `copy /b wsl.zstd.01 + wsl.zstd.02 + wsl.zstd.03 wsl.tar.zstd` (put all files)
* Decompress the tarball into a `wsl.tar` file
* Import in WSL2:
  * `wsl --import didattica PATH_TO_THE_WLS_FILE_SYSTEM wsl.tar --version 2`

### Launch as WSL2 distro:

1. Launch VcXsrv with the configuration mentioned before
2. Use the Powershell command `Get-NetIPAddress -AddressFamily ipv4` to get your IP address
3. Run the following in Powershell, substituting `<YOUR_IP>` with your IP address:

```Powershell
$DISPLAY="<YOUR_IP>:0.0"
$env:DISPLAY=$DISPLAY
$env:WSLENV="DISPLAY/u"
wsl -d didattica -u user zsh
```

## Run on Mac OS X

TBD
