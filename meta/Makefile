genuses:
	cd uses && \
  java -jar /usr/share/java/Saxon-HE.jar -xi use.xml ../makeuse.xsl

genstructs:
	cd structs && \
  java -jar /usr/share/java/Saxon-HE.jar -xi structs.xml ../makestruct.xsl

genfuncs:
	cd uses && \
  java -jar /usr/share/java/Saxon-HE.jar -xi use.xml ../makefunctions.xsl


castxml2pony_uses:
	rm -rf uses && \
	mkdir -p uses && \
	cd uses && \
	../../../castxml2pony/castxml2pony --renderdefault -x ../libxml2.xml -u `grep '<File ' ../libxml2.xml | grep '/libxml2/' | cut -d'"' -f2`

castxml2pony_structs:
	rm -rf structs && \
	mkdir -p structs && \
	cd structs && \
	../../../castxml2pony/castxml2pony --renderdefault -x ../libxml2.xml -s `grep '<File ' ../libxml2.xml | grep '/libxml2/' | cut -d'"' -f2`

castxml:
	castxml --castxml-output=1 libxml2.h -I /usr/include/libxml2
