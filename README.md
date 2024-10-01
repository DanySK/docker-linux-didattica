# Manjaro Linux virtual machine for teaching

I'm tired of stuff not working with Windows and dual boots are apparently not a thing in my university,
VMs drain too many resources,
some students have Linux/Mac PCS...
So I adopted docker

* Link to the [docker hub page](https://hub.docker.com/repository/docker/danysk/linux-didattica)
* Quickly pull it via: `docker pull danysk/linux-didattica:latest`

## Run on linux

```bash
xhost "+local:*"
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
  * Bash (requires a UNIX-like shell: `sh`, `bash`, `zsh`, `fish`... won't work on Powershell or Cmd): `cat *.tar.zstd.* > wsl.tar.zstd`
  * Cmd: `copy /b wsl.tar.zstd.00 + wsl.tar.zstd.01 + wsl.tar.zstd.02 wsl.tar.zstd` (add all the downloaded files)
* Decompress the tarball into a `wsl.tar` file
  * If you have [Z-standard](http://facebook.github.io/zstd/) installed, simply: `unzstd wsl.tar.zstd`
  * If `unzstd` is not installed, but you have access to `zstd` or `zstd.exe`, run: `zstd -d wsl.tar.zstd`
  * If you prefer a graphical tool, check out [PeaZip](https://peazip.github.io/)
* Import in WSL2 (replace `PATH_TO_THE_WLS_FILE_SYSTEM` with a valid path):
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

### Prerequisites

0. Install Docker following the instructions provided [here](https://docs.docker.com/desktop/mac/install/)
  - beware that Mac machines with Apple Chips require installing Rosetta first

1. Install [`xquartz`](https://www.xquartz.org/) from [Homebrew](https://brew.sh)
  ```bash
  brew install xquartz
  ```

2. Reboot your Mac after installing `xquartz`

3. Start the XQuartz application

4. Open then preferences dialog of the XQuartz application, go to the _Security_ section, and enable the flag _Allow connections from network clients_, as depicted below (more details [here](https://techsparx.com/software-development/docker/display-x11-apps.html)):

  ![XQuartz preferences dialog, security tab](https://techsparx.com/software-development/docker/img/xquartz-security.png)

### Running the container

1. Start XQuartz application

2. Run the following commands in your shell
  ```bash
  export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

  xhost +$IP

  docker run --rm --name linux-didattica --net=host -e "DISPLAY=$IP:0" -e XAUTHORITY=/.Xauthority -v <WHERE_TO_LOCALLY_PERSIST>:/home/user --volume="$HOME/.Xauthority:/.Xauthority:rw" -v /tmp/.X11-unix:/tmp/.X11-unix -it danysk/linux-didattica
  ```
