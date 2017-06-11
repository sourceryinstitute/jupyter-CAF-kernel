NAME = sourceryinstitute/jupyter-caf-kernel
#WORKDIR = ${HOME}/Sandbox

default: build

build:
	@hooks/build 2>&1 | tee $(subst /,_,$(NAME))-build.log

push:
	docker push $(NAME)
	[[ -n "${SI_jupyter_CAF_kernel_UBADGER_ENDPOINT}" ]] && curl -X POST ${SI_jupyter_CAF_kernel_UBADGER_ENDPOINT}

run:
	docker run -i -t -p 8888:8888 $(NAME)
runclean:
	docker run --rm -i -t -p 8888:8888 $(NAME)

release: build push
