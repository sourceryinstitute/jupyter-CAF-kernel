
ifeq ($(MAKECMDGOALS),)
  MAKECMDGOALS := help
endif

$(MAKECMDGOALS): ## Recurse into ./prebuild and execute make as invoked here
	$(MAKE) -C prebuild $(MAKECMDGOALS)
