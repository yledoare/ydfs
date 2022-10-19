srcdir=$HOME/docbook-build/src
pkgdir=$HOME/docbook-build/pkg



pkgname=docbook-xml
pkgver=4.5
pkgrel=6

install -d $srcdir
install -d $pkgdir
cd $srcdir

wget https://downloads.sourceforge.net/docbook/docbook-xsl-1.79.1.tar.bz2
tar xjvf docbook-xsl-1.79.1.tar.bz2
cd docbook-xsl-1.79.1
install -d ${pkgdir}/usr/share/xml/docbook/xsl-stylesheets-1.79.1
cp -v -R VERSION assembly common eclipse epub epub3 extensions fo        \
      highlighting html htmlhelp images javahelp lib manpages params  \
      profiling roundtrip slides template tests tools webhelp website \
	    xhtml xhtml-1_1 xhtml5                                          \
		  ${pkgdir}/usr/share/xml/docbook/xsl-stylesheets-1.79.1

xmlcatalog --noout --add "rewriteSystem" \
          "http://docbook.sourceforge.net/release/xsl/1.79.1" \
          "${pkgdir}/usr/share/xml/docbook/xsl-stylesheets-1.79.1" \
				 "${pkgdir}/etc/xml/docbook-xml"

xmlcatalog --noout --add "rewriteURI" \
         "http://docbook.sourceforge.net/release/xsl/1.79.1" \
         "${pkgdir}/usr/share/xml/docbook/xsl-stylesheets-1.79.1" \
				 "${pkgdir}/etc/xml/docbook-xml"

xmlcatalog --noout --add "rewriteSystem" \
        "http://docbook.sourceforge.net/release/xsl/current" \
        "${pkgdir}//usr/share/xml/docbook/xsl-stylesheets-1.79.1" \
				 "${pkgdir}/etc/xml/docbook-xml"

xmlcatalog --noout --add "rewriteURI" \
        "http://docbook.sourceforge.net/release/xsl/current" \
        "${pkgdir}/usr/share/xml/docbook/xsl-stylesheets-1.79.1" \
				 "${pkgdir}/etc/xml/docbook-xml"
cd ..

wget http://www.docbook.org/xml/4.5/docbook-xml-4.5.zip
wget http://www.docbook.org/xml/4.4/docbook-xml-4.4.zip
wget http://www.docbook.org/xml/4.3/docbook-xml-4.3.zip
wget http://www.docbook.org/xml/4.2/docbook-xml-4.2.zip
wget http://www.docbook.org/xml/4.1.2/docbkx412.zip

  for ver in 4.2 4.3 4.4 4.5; do
		    mkdir docbook-xml-${ver}
				    pushd docbook-xml-${ver}
						    unzip "${srcdir}/docbook-xml-${ver}.zip"
								    mkdir -p "${pkgdir}/usr/share/xml/docbook/xml-dtd-${ver}"
										    cp -dRf docbook.cat *.dtd ent/ *.mod \
													        "${pkgdir}/usr/share/xml/docbook/xml-dtd-${ver}/"
												    popd
														  done
															  mkdir docbook-xml-4.1.2
																  pushd docbook-xml-4.1.2
																	  unzip "${srcdir}/docbkx412.zip"
																		  mkdir -p "${pkgdir}/usr/share/xml/docbook/xml-dtd-4.1.2"
																			  cp -dRf docbook.cat *.dtd ent/ *.mod \
																					      "${pkgdir}/usr/share/xml/docbook/xml-dtd-4.1.2/"
																				  popd

																					  mkdir -p "${pkgdir}/etc/xml"
																						  xmlcatalog --noout --create "${pkgdir}/etc/xml/docbook-xml"


  # V4.1.2
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/calstblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/calstblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/soextblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Information Pool V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbpoolx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbhierx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbgenent.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Notations V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbnotnx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Character Entities V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbcentx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.1.2" \
    "file:///usr/share/xml/docbook/xml-dtd-4.1.2" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.1.2" \
    "file:///usr/share/xml/docbook/xml-dtd-4.1.2" \
    "${pkgdir}/etc/xml/docbook-xml"

  # V4.2
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook CALS Table Model V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/calstblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/soextblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Information Pool V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbpoolx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbhierx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Additional General Entities V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbgenent.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Notations V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbnotnx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Character Entities V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbcentx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.2" \
    "file:///usr/share/xml/docbook/xml-dtd-4.2" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.2" \
    "file:///usr/share/xml/docbook/xml-dtd-4.2" \
    "${pkgdir}/etc/xml/docbook-xml"

  # V4.3
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook CALS Table Model V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/calstblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/soextblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Information Pool V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbpoolx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbhierx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Additional General Entities V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbgenent.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Notations V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbnotnx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Character Entities V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbcentx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.3" \
    "file:///usr/share/xml/docbook/xml-dtd-4.3" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.3" \
    "file:///usr/share/xml/docbook/xml-dtd-4.3" \
    "${pkgdir}/etc/xml/docbook-xml"

  # V4.4
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/docbookx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook CALS Table Model V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/calstblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/htmltblx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/soextblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Information Pool V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbpoolx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbhierx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Additional General Entities V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbgenent.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Notations V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbnotnx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Character Entities V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbcentx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.4" \
    "file:///usr/share/xml/docbook/xml-dtd-4.4" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.4" \
    "file:///usr/share/xml/docbook/xml-dtd-4.4" \
    "${pkgdir}/etc/xml/docbook-xml"

  # V4.5
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.5//EN" \
    "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/calstblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/soextblx.dtd" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbhierx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/htmltblx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Notations V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbcentx.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbgenent.mod" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.5" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
    "${pkgdir}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.5" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
    "${pkgdir}/etc/xml/docbook-xml"

# license
