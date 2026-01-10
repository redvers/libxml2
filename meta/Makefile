all:
	echo Be careful in here, okay?

install_raw:
	rm -rf ../libxml2/raw && \
	mkdir -p ../libxml2/raw && \
	cp structs.pony uses.pony functions.pony ../libxml2/raw

genuses:
	cd uses && \
  java -jar /usr/share/java/Saxon-HE.jar -xi use.xml ../makeuse.xsl && \
	rm -f `grep -l Valisttag uses/*` && \
	rm -f uses/__* && \
	cat uses/*.use > ../uses.pony

genstructs:
	cd structs && \
  java -jar /usr/share/java/Saxon-HE.jar -xi structs.xml ../makestruct.xsl && \
	echo 'struct IOFILE' > ../structs.pony && \
	cat structs/*/*.struct >> ../structs.pony

genfuncs:
	cd uses && \
  java -jar /usr/share/java/Saxon-HE.jar -xi use.xml ../makefunctions.xsl && \
	rm -f `grep -l Valisttag fns/*` && \
	rm -f `grep -l 'Array\[' fns/*` && \
	rm -f fns/__* && \
	echo 'use "lib:xml2"' > ../functions.pony && \
	echo '' >> ../functions.pony && \
	echo 'primitive LibXML2' >> ../functions.pony && \
	cat fns/* >> ../functions.pony


castxml2pony_uses:
	rm -rf uses && \
	mkdir -p uses && \
	cd uses && \
	../../../castxml2pony/castxml2pony --renderdefault -x ../libxml2.xml -u `grep '<File ' ../libxml2.xml | grep '/libxml2/' | cut -d'"' -f2` && \
	sed -i -re 's/<usearg name="([A-Z])/<usearg name="\l\1/g' use.xml && \
	sed -i -e 's/<usearg name="type"/<usearg name="xmltype"/g' use.xml && \
	sed -i -e 's/<usearg name="val"/<usearg name="xmlval"/g' use.xml && \
	sed -i -e 's/<usearg name="ref"/<usearg name="xmlref"/g' use.xml && \
	sed -i -e 's/<usearg name="tag"/<usearg name="xmltag"/g' use.xml && \
	sed -i -e 's/<usearg name="end"/<usearg name="xmlend"/g' use.xml && \
	sed -i -e 's/<usearg name="in"/<usearg name="xmlin"/g' use.xml && \
	sed -i -e 's/ponyname="UTF8/ponyname="utf8/g' use.xml && \
	sed -i -e 's/ponyname="xmlBufferWriteCHAR/ponyname="xmlBufferWriteXmlChar/g' use.xml && \
	sed -i -e 's/<usearg name="recover"/<usearg name="xmlrecover"/g' use.xml && \
	sed -i -e 's/<usearg name="error"/<usearg name="xmlerror"/g' use.xml && \
	echo

castxml2pony_structs:
	rm -rf structs && \
	mkdir -p structs && \
	cd structs && \
	../../../castxml2pony/castxml2pony --renderdefault -x ../libxml2.xml -s f39 `grep '<File ' ../libxml2.xml | grep '/libxml2/' | cut -d'"' -f2` && \
	sed -i -e 's/<field name="_*/<field name="/g' structs.xml && \
	sed -i -re 's/<field name="([A-Z])/<field name="\l\1/g' structs.xml && \
	sed -i -e 's/<field name="type"/<field name="xmltype"/g' structs.xml && \
	sed -i -e 's/<field name="error"/<field name="xmlerror"/g' structs.xml && \
	sed -i -e 's/<field name="use"/<field name="xmluse"/g' structs.xml && \
	sed -i -e 's/<field name="end"/<field name="xmlend"/g' structs.xml && \
	sed -i -e 's/<field name="ref"/<field name="xmlref"/g' structs.xml && \
	sed -i -e 's/<field name="val"/<field name="xmlval"/g' structs.xml && \
	echo

castxml:
	castxml --castxml-output=1 libxml2.h -I /usr/include/libxml2
