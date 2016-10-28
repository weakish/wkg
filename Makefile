# Compatible with GNU make and BSD make.

include config.mk

install:
	@echo Installing to to ${PREFIX}/bin ...
	@mkdir -p ${PREFIX}/bin
	@cp -f wkg.sh ${PREFIX}/bin/wkg
	@chmod 755 ${PREFIX}/bin/wkg

uninstall:
	@echo Uninstalling from ${PREFIX}/bin ...
	@rm -f ${PREFIX}/bin/wkg
