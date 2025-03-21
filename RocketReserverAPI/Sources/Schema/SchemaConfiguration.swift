// @generated
// This file was automatically generated and can be edited to
// provide custom configuration for a generated GraphQL schema.
//
// Any changes to this file will not be overwritten by future
// code generation execution.

import ApolloAPI

public enum SchemaConfiguration: ApolloAPI.SchemaConfiguration {
    public static func cacheKeyInfo(for type: Object, object: ObjectData) -> CacheKeyInfo? {
//        print("DEBUG: Generating cache key for type: \(type)")

        if type.typename == "Launch", let id = object["id"] as? String {
            let cacheKeyInfo = CacheKeyInfo(
                id: id,
                uniqueKeyGroup: type.typename
            )
            print("DEBUG: Generated cache key: \(cacheKeyInfo)")
            return cacheKeyInfo
        }

        // print("DEBUG: No ID found in object data: \(object)")
        return nil
    }
}
