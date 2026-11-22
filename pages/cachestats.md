# CacheStats

The CacheStats function will return a statistics counter of the
specified bucket in the cache.

## COMMAND SYNTAX

    CacheStats(bucket, counter_id)

## EXAMPLE

    INCLUDE JBC.h
    CachePut('bucket1', 'item1', 'value1')
    CachePut('bucket1', 'item2', 'value2')
    CacheGet('bucket1', 'item1')
    CacheGet('bucket1', 'item3')
    CRT "CACHE_HITS: " : CacheStats('bucket1', CACHE_HITS)
    CRT "CACHE_GETS: " : CacheStats('bucket1', CACHE_GETS)
    CRT "CACHE_PUTS: " : CacheStats('bucket1', CACHE_PUTS)
    CRT "CACHE_SIZE: " : CacheStats('bucket1', CACHE_SIZE)
    CRT "CACHE_NB_ITEMS: " : CacheStats('bucket1', CACHE_NB_ITEMS)

The output is:

<pre>
    CACHE_HITS: 1
    CACHE_GETS: 2
    CACHE_PUTS: 2
    CACHE_SIZE: 12
    CACHE_NB_ITEMS: 2</pre>

## NOTES

The "counter_id" parameter may have following values:

**CACHE_HITS**: Number of successful hits to the bucket.
This counter is incremented by CacheGet function if a requested
item exists in the bucket.

**CACHE_GETS**: Number of reads from the bucket.
This counter is incremented by CacheGet on every call.

**CACHE_PUTS**: Number of writes to the bucket.
This counter is incremented by CachePut on every call.

**CACHE_SIZE**: Total size of the bucket in bytes.
This parameter is calculated by adding the lengths of all items of
the bucket which have a String.

**CACHE_NB_ITEMS**: Number of items in the bucket.

This function does not affect statistics of the bucket.
