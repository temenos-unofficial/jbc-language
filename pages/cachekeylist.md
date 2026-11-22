# CacheKeyList

The CacheKeyList function will return a list of all item names in the
specified bucket in the cache. The list is represented as a string
containing the item names joined together via a given delimiter.

## COMMAND SYNTAX

    CacheKeyList(bucket, delimiter)

## EXAMPLE

    INCLUDE JBC.h
    CachePut('bucket1', 'item1', 'value1')
    CachePut('bucket1', 'item2', 'value1')
    keys = CacheKeyList('bucket1', @AM)
    CRT 'First name: ':keys<1>
    CRT 'Second name: ':keys<2>

The output is:

<pre>
    First name: item1
    Second name: item2</pre>

## NOTES

This function does not affect statistics of the bucket.

***TAFJ note: list isn't sorted by item name like it is in TAFC.***
