# XMLTODYN

XMLTODYN converts the XML to a dynamic array using the optional XSL.

## COMMAND SYNTAX

    XMLTODYN(XML, XSL, result)

## SYNTAX ELEMENTS

Array = XMLTODYN(XML,XSL,result)

If result = 0 Array will contain a dynamic array built from the xml / xsl

If result <> 0, Array will contain an error message

There is no requirement for xsl if you are reconverting from generic xml
to dynarray

    a = "Tom" : @AM : "Dick" : @AM : "Harry"
    xml = DYNTOXML(a, '', result)
    b = XMLTODYN(xml, '', result
    CRT CHANGE(b, @AM, ' ')

Screen output:

<pre>
    Tom Dick Harry</pre>

If passing a stylesheet in the second parameter, it performs a transform
to give a different format of the array.

*XML CONTENTS*

<pre>
    &lt;?xml version="1.0" encoding="UTF-8"?&gt;
    &lt;mycustomer&gt;
      &lt;firstname&gt;Tom&lt;/firstname&gt;
      &lt;lastname&gt;Dick&lt;/lastname&gt;
      &lt;address&gt;Harry&lt;/address&gt;
    &lt;/mycustomer></pre>

## EXAMPLE

    a = XMLTODYN(xml, xsl, rc)
    CRT CHANGE(a, @AM, ' ')

## XSL CONTENTS

<pre>
    &lt;xsl:template match="mycustomer"&gt;
    &lt;array&gt;
    &lt;xsl:apply-templates/&gt;
    &lt;/array&gt;
    &lt;/xsl:template&gt;
    &lt;xsl:template match="firstname"&gt;
    &lt;data&gt;
    &lt;xsl:attribute name="attribute"&gt;1&lt;/xsl:attribute&gt;
    &lt;xsl:attribute name="value"&gt;
	  &lt;xsl:number level="single"/&gt;
    &lt;/xsl:attribute&gt;
    &lt;xsl:attribute name="subvalue"&gt;1&lt;/xsl:attribute&gt;
    &lt;xsl:value-of select="."/&gt;
    &lt;/data&gt;
    &lt;/xsl:template&gt;
    Etc</pre>
