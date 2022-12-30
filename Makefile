DOCKER ?= docker
UBUNTU_RELEASE ?= focal
IMAGE_VERSION ?= 2022.2
IMAGE_NAME ?= vivado-vitis

all: help

help:
	@echo
	@echo ================================================================
	@echo " Vivado Vitis Container"
	@echo
	@echo " make install-image"
	@echo " make run-gui"
	@echo " make run-gui"
	@echo
	@echo ================================================================
	@echo

install-image:
	$(DOCKER) build --build-arg ubuntu_release=$(UBUNTU_RELEASE) .

run-cli:
	$(DOCKER) run -it --rm -v $(PWD):/work:z -w /work $(IMAGE_NAME)-$(IMAGE_VERSION)

run-gui:
	$(DOCKER) run -it --rm -v $(PWD):/work:z -w /work \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v $(HOME)/.Xauthority:/.Xauthority \
		--network host \
		$(IMAGE_NAME)-$(IMAGE_VERSION)

.PHONY: cli gui run-cli run-gui
