FROM?=ubuntu:18.04

SUFFIX?=_vimdbg
VIMRC=$(shell echo $$HOME)/.vimrc

all: build

#TODO: Need to error out for non-debian based containers.
#TODO: Need to allow specifying existing .vimrc and .bash_aliases and .tmux.conf for personalized experience.
preamble:
	( [ -L .vimrc ] || [ -f .vimrc ] ) && rm .vimrc || true
	( [ -z $(DOTFILES) ] || ( [ -f $(VIMRC) ] || [ -L $(VIMRC) ] && [ -e $(VIMRC) ] ) && cp $(VIMRC) .vimrc ) || true
	( [ -z $(DOTFILES) ] && touch .vimrc ) || true

build: preamble 
	docker build -t $(FROM)$(SUFFIX) --network=host --build-arg from=$(FROM) .
