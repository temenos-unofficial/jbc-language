# XMLTOXML

XMLTOXML transforms the XML using the XSL.

## COMMAND SYNTAX

    XMLTOXML(xml,xsl,result)

## SYNTAX ELEMENTS

If result=0, newxml will contain a transformed version of xml using xsl.

If result=1, newxml will hold an error message.

*XSL CONTENTS*

<pre>
    &lt;?xml version="1.0" ?&gt;
    &lt;xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"&gt;
    &lt;xsl:template match="person"&gt;
    &lt;p&gt;&lt;xsl:value-of select="name" /&gt;&lt;/p&gt;
    &lt;/xsl:template&gt;
    &lt;/xsl:stylesheet&gt;</pre>

*XML CONTENTS*

<pre>
    &lt;list&gt;
    &lt;person&gt;
	    &lt;name&gt;Bob&lt;/name&gt;
    &lt;/person&gt;
    &lt;person&gt;
	    &lt;name&gt;Amy&lt;/name&gt;
    &lt;/person&gt;
    &lt;/list&gt;</pre>

## EXAMPLE

    newxml = XMLTOXML(xml,xsl,rc)
    CRT newxml

*SCREEN OUTPUT*

<pre>
    &lt;p&gt;Bob&lt;/p&gt;&lt;p&gt;Amy&lt;/p&gt;</pre>
