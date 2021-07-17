FROM?=ubuntu:18.04

all: build

#TODO: Need to error out for non-debian based containers.
#TODO: Need to allow specifying existing .vimrc and .bash_aliases and .tmux.conf for personalized experience.
preamble:
	@echo The base image is $(FROM)

build: preamble 
	docker build -t devwrapper_$(FROM) --build-arg from=$(FROM) .
