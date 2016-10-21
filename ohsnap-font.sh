#!/bin/bash
if [[ $UID == "0" ]]; then
	printf "\n[ohsnap]: downloading font package from sourceforge.net [internode mirror]...\n\n" && wait
	curl http://internode.dl.sourceforge.net/project/osnapfont/ohsnap-1.8.0.tar.gz > ohsnap-1.8.0.tar.gz && wait
	printf "\n[ohsnap]: downloading font package from sourceforge.net [internode mirror]... done!\n\n"
	tar xvf ohsnap-1.8.0.tar.gz 1>2&
	cd ohsnap-1.8.0/
	printf "[ohsnap]: writing configuration for bitmap font... "
	echo "<?xml version="1.0"?>
	   <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
	      <fontconfig>
	         <selectfont>
	            <acceptfont>
	               <pattern>
	                  <patelt name="family"><string>Ohsnap</string></patelt>
	               </pattern>
	            </acceptfont>
	        </selectfont>
	      </fontconfig>" > 50-ohsnap-enable.conf
	printf " done!\n\n"
	printf "[ohsnap]: installing configuration for bitmap font... "
	cp 50-ohsnap-enable.conf /etc/fonts/conf.d/50-ohsnap-enable.conf 1>2&
	printf "done!\n\n"
	printf "[ohsnap]: installing required font files... "
	cp *.pcf /usr/share/fonts/X11/misc/ 1>2&
	sudo cp *.psfu /usr/share/fonts/X11/misc/ 1>2&
	printf "done!\n\n"
	printf "[ohsnap]: refreshing systems font index...\n"
	dpkg-reconfigure fontconfig
	printf "[ohsnap]: refreshing systems font index... done!\n\n"
        printf "[ohsnap]: font installation has finished.\n"
else
	printf "[ohsnap]: root access is required to use this installer, please run this script with appropriate permissions.\n"
	exit 1
fi

exit 0
