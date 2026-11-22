# CacheDelete

The CacheBucketList function will delete an item from a bucket in
the cache.

## COMMAND SYNTAX

    CacheDelete(bucket, item)

## EXAMPLE

    INCLUDE JBC.h
    CacheDelete('bucket1', 'item1')
    CachePut('bucket2', 'item1', 'value1')
    buckets = CacheBucketList(@AM)
    CRT "First bucket: " : buckets<1>
    CRT "Second bucket: " : buckets<2>

The output is:

<pre>
    First bucket: bucket1
    Second bucket: bucket2</pre>

## NOTES

This function does not affect statistics of the bucket.
