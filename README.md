# Vivado Vitis Container

## Setup

### [Vivado](https://www.xilinx.com/products/design-tools/vivado.html)

```shell
export WORKSPACE_PATH=`pwd`
export INSTALLER_PATH=$HOME/storage/xilinx
export INSTALLER_NAME=Xilinx_Unified_2022.2_1014_8888_Lin64
export IMAGE_NAME=vivado-vitis
export IMAGE_VERSION=2022.2
```

```shell
chmod +x $INSTALLER_PATH/$INSTALLER_NAME.bin
$INSTALLER_PATH/$INSTALLER_NAME.bin --noexec --keep --target $INSTALLER_PATH/$INSTALLER_NAME
```

## Configuration (Optional)

An [install configuration](install_config.txt) is provided in this repository.
To generate the vendor provided default configuration or create your own from a
template:

```shell
$INSTALLER_PATH/$INSTALLER_NAME/xsetup -b ConfigGen -l /opt/Xilinx
mv ~/.Xilinx/install_config.txt $WORKSPACE_PATH/
```

## Build

```shell
docker image build -t $IMAGE_NAME .
```

## Install

### CLI

```shell
docker run -it --name $INSTALLER_NAME \
    -e INSTALLER_NAME=$INSTALLER_NAME \
    -v $WORKSPACE_PATH:/work:z \
    -v $INSTALLER_PATH:/install:z \
    -w /work \
    $IMAGE_NAME
```

```shell
/install/$INSTALLER_NAME/xsetup -b AuthTokenGen
/install/$INSTALLER_NAME/xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config install_config.txt
exit
```

### GUI

```shell
apt-get -y --no-install-recommends install xorg
```

```shell
sudo setenforce 0
```

```shell
docker run -it --name $INSTALLER_NAME \
    -e INSTALLER_NAME=$INSTALLER_NAME \
    -v $WORKSPACE_PATH:/work \
    -v $INSTALLER_PATH:/install \
    -w /work \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:/.Xauthority \
    --network host \
    $IMAGE_NAME \
    /install/$INSTALLER_NAME/xsetup
```

```shell
sudo setenforce 1
```

## Commit

```shell
docker commit $INSTALLER_NAME $IMAGE_NAME-$IMAGE_VERSION
docker rm $INSTALLER_NAME
```

## Usage

### Setup

```shell
export WORKSPACE_PATH=`pwd`
export IMAGE_NAME=vivado-vitis
export VIVADO_VERSION=2022.2
```

### CLI

```shell
docker run -it --rm -v $WORKSPACE_PATH:/work:z -w /work $IMAGE_NAME-$IMAGE_VERSION
```

### GUI

```shell
sudo setenforce 0
```

```shell
docker run -it --rm \
    -v $WORKSPACE_PATH:/work \
    -w /work \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:/.Xauthority \
    --network host \
    $IMAGE_NAME-$IMAGE_VERSION
```

```shell
source /opt/Xilinx/Vitis_HLS/2021.1/settings64.sh
GTK_THEME=Adwaita:dark vitis_hls
```

```shell
sudo setenforce 1
```
