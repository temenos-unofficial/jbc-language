# DYNTOXML

## COMMAND SYNTAX

    DYNTOXML(array, xsl, result)

## SYNTAX ELEMENTS

Convert the array to XML using the optimal xsl to transform

    XML = DYNTOXML(array, '', result)

Takes the contents of the dynamic array held in an array, and returns a
generic XML representation of that array or an error

(result=0 OK; result<>0 Bad);

## EXAMPLE

    a = "Tom" : @AM : "Dick" : @AM : "Harry"
    xml = DYNTOXML(a, '', result)
    CRT xml

**SCREEN OUTPUT**

<pre>
    &lt;?xml version="1.0" encoding ="ISO-8859-1"?&gt;
    &lt;array&gt;
      &lt;data attribute="1" value="1" subvalue="1">Tom&lt;/data&gt;
      &lt;data attribute="2" value="1" subvalue="1">Dick&lt;/data&gt;
      &lt;data attribute="3" value="1" subvalue="1">Harry&lt;/data&gt;
    &lt;/array&gt;</pre>

If a style sheet is passed in the second parameter, it performs a
transform to give a different format of XML.

## EXAMPLE

    xml = DYNTOXML(a, xsl, result)
    CRT xml

**SCREEN OUTPUT**

<pre>
    &lt;mycustomer&gt;
      &lt;firstname&gt;Tom&lt;/firstname&gt;
      &lt;lastname&gt;Dick&lt;/lastname&gt;
      &lt;address&gt;Harry&lt;/address&gt;
    &lt;/mycustomer&gt;</pre>

**XSL CONTENTS**

<pre>
    &lt;xsl:template match="/"&gt;
    &lt;mycustomer&gt;
      &lt;xsl:for-each select="array/data"&gt;
        &lt;xsl:if test="@attribute=1"&gt;
          &lt;firstname&gt;
            &lt;xsl:value-of select="."/&gt;
          &lt;/firstname&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="@attribute=2"&gt;
          &lt;lastname&gt;
            &lt;xsl:value-of select="."/&gt;
          &lt;/lastname&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="@attribute=3"&gt;
          &lt;address&gt;
            &lt;xsl:value-of select="."/&gt;
          &lt;/address&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="@attribute=4"&gt;
          &lt;address2&gt;
            &lt;xsl:value-of select="."/&gt;
          &lt;/address2&gt;
       &lt;/xsl:if&gt;</pre>
