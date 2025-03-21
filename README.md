# Apollo iOS Cache Bug Test Case

This repository contains a minimal test case demonstrating a caching issue with Apollo iOS client.

## Issue Description

When executing different queries that request the same data with identical cache keys, the Apollo client doesn't fetch from cache as expected according to the [Apollo iOS caching documentation](https://www.apollographql.com/docs/ios/caching/introduction).

## Expected Behavior

-   When executing Query B that requests the same data as previously cached Query A
-   And the objects have the same cache keys
-   The data should be fetched from cache

## Current Behavior

The client performs a new network request instead of using cached data.

## Steps to Reproduce

1. Execute first query that caches data
2. Execute second query requesting same fields
3. Observe network requests instead of cache hits

## Environment

-   Apollo iOS Client version: [YOUR_VERSION]
-   iOS version: [iOS_VERSION]
-   Xcode version: [XCODE_VERSION]

## Related Documentation

-   [Apollo iOS Caching Documentation](https://www.apollographql.com/docs/ios/caching/introduction)
