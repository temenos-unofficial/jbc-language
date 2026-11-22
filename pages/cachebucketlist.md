# CacheBucketList

The CacheBucketList function will return a list of all buckets in the
cache. The list is represented as a string containg the bucket names
joined together via a given delimiter.

## COMMAND SYNTAX

    CacheBucketList(delimiter)

## EXAMPLE

    INCLUDE JBC.h
    CachePut('bucket1', 'item1', 'value1')
    CachePut('bucket2', 'item1', 'value1')
    buckets = CacheBucketList(@AM)
    CRT "First bucket: " : buckets<1>
    CRT "Second bucket: " : buckets<2>

The output is:

<pre>
    First bucket: bucket1
    Second bucket: bucket2</pre>

## NOTES

This function does not affect the bucket statistics.

***TAFJ note: list isn't sorted by bucket name like it is in TAFC.***
