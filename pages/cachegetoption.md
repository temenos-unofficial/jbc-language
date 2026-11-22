# CacheGetOption

The CacheGetOption function will return an option of the bucket.

## COMMAND SYNTAX

    CacheGetOption(bucket,  option)

## EXAMPLE

    INCLUDE JBC.h
    CRT 'CACHE_MAX_SIZE: ': CacheGetOption('bucket1', CACHE_MAX_SIZE)
    CRT 'CACHE_PURGE_THRESHOLD: ': CacheGetOption('bucket1', CACHE_PURGE_THRESHOLD)
    CachePut('bucket1', 'item1', 'value1')
    CRT 'CACHE_MAX_SIZE: ': CacheGetOption('bucket1', CACHE_MAX_SIZE)
    CRT 'CACHE_PURGE_THRESHOLD: ': CacheGetOption('bucket1', CACHE_PURGE_THRESHOLD)

The output is:

<pre>
    CACHE_MAX_SIZE: 0
    CACHE_PURGE_THRESHOLD: 0
    CACHE_MAX_SIZE: 1048576
    CACHE_PURGE_THRESHOLD: 90</pre>

## NOTES

The bucket should exists otherwise this function returns zeros.

The "option" parameter may have following values:

**CACHE_MAX_SIZE**: Bucket maximum size in bytes. By default, the
bucket size is 1048576. If the size reaches this value, the most
outdated data will be purged from the bucket to reduce its size.

**CACHE_PURGE_THRESHOLD**: Percentage (from 1 to 100) of a bucket
size exceeding of which leads to the bucket purging. By default,
it's value is 90. When a bucket size exceeds the
(CACHE_MAX_SIZE * CACHE_PURGE_THRESHOLD / 100) value the most
outdated data will be purged from the bucket to reduce its size.

This function does not affect statistics of the bucket.
