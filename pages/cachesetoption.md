# CacheSetOption

The CacheSetOption function will set an option of the bucket.

## COMMAND SYNTAX

    CacheSetOption(bucket,  option, value)

## EXAMPLE

    INCLUDE JBC.h
    CacheSetOption('bucket1', CACHE_MAX_SIZE, 100000)
    CacheSetOption('bucket1', CACHE_PURGE_THRESHOLD, 60)

## NOTES

If the bucket does not exist an empty bucket is created and the option
is applied to it.

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
