SHELL := /usr/local/bin/bash -o pipefail
NAME = sourceryinstitute/jupyter-caf-kernel
#WORKDIR = ${HOME}/Sandbox

.PHONY: help build push run runclean clean
.DEFAULT_GOAL := help

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'

help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

build: $(subst /,_,$(NAME))-build.stamp ## Build docker file. Depending on which packages are rebuilt this may take a long time

$(subst /,_,$(NAME))-build.stamp: Dockerfile .dockerignore hooks/build ## Target for doing & timestamping the build
	touch $@
	@hooks/build 2>&1 | tee $(subst stamp,log,$@) || rm -rf $(subst stamp,log,$@)

push: build $(subst /,_,$(NAME))-push.stamp ## Push prebuild docker image up to hub.docker.com

$(subst /,_,$(NAME))-push.stamp: ## Target for doing & timestamping the push
	touch $@
	docker push $(NAME) | tee $(subst stamp,log,$@) || rm -rf $(subst stamp,log,$@)
	[[ -n "${SI_jupyter_CAF_kernel_UBADGER_ENDPOINT}" ]] && curl -X POST ${SI_jupyter_CAF_kernel_UBADGER_ENDPOINT}

run: $(subst /,_,$(NAME))-run.stamp ## Target to run jupyter-hub docker server

$(subst /,_,$(NAME))-run.stamp: ## Target for doing the actual run and timestamp
	touch $@
	docker run -i -t -p 8888:8888 $(NAME) | tee $(subst stamp,log,$@) || rm -rf $(subst stamp,log,$@)

runclean: $(subst /,_,$(NAME))-runclean.stamp ## Target to run jupyter-hub docker server, discarding changes

$(subst /,_,$(NAME))-runclean.stamp: ## Target for doing the actual runclean and timestamp
	touch $@
	docker run --rm -i -t -p 8888:8888 $(NAME) | tee $(subst stamp,log,$@) || rm -rf $(subst stamp,log,$@)

clean:
	rm -rf $(subst /,_,$(NAME))*.stamp
