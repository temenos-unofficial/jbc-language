# GROUPSTORE

Insert the variable contents into dynamic array (or replace an element in it).

## COMMAND SYNTAX

    GROUPSTORE from.var IN to.var USING start, replace, delimiter

## EXAMPLE

        to.var = 'QQQ' :@FM: 'WWW' :@FM: 'EEE'
        from.var = 'rtz'
        GROUPSTORE from.var IN to.var USING 2, 0, @FM   ;* start,replace,delim
        CRT FMT(to.var, 'MCP')                          ;* QQQ^rtz^WWW^EEE
        GROUPSTORE from.var IN to.var USING 4, 1
        CRT FMT(to.var, 'MCP')                          ;* QQQ^rtz^WWW^rtz
        GROUPSTORE from.var IN to.var USING 2, 0, @VM
        CRT FMT(to.var, 'MCP')                          ;* QQQ^rtz^WWW^rtz]rtz

***TAFJ note: GROUPSTORE statement isn't supported.***
