# CacheExists

The CacheExists function will return "1" if a item exists in the
bucket or "0" otherwise.

## COMMAND SYNTAX

    CacheExists(bucket, item)

## EXAMPLE

    INCLUDE JBC.h
    CRT CacheExists('bucket1', 'item1')
    CachePut('bucket1', 'item1', 'value1')
    CRT CacheExists('bucket1', 'item1')
    CRT CacheExists('bucket2', 'item1')

The output is:

<pre>
    0
    1
    0</pre>

## NOTES

The CacheExists() function also returns "0" if the bucket itself
does not exist in the cache. Also this function does not affect
statistics of the bucket.
