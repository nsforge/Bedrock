//
//  NSDictionary+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (Bedrock)


//
// Filtering/Selecting/Finding
//

- (NSDictionary<KeyType, ObjectType> *)br_allEntriesWhere:(BOOL (^)(KeyType key, ObjectType obj))block;


//
// Mapping
//

// Entries that return nil won't be added to the resulting array.
- (NSArray *)br_arrayByMapping:(nullable id (^)(KeyType key, ObjectType obj))block;

// Will return a dictionary with the original keys, and objects that are the returned values of <block>.
- (NSDictionary<KeyType, id> *)br_dictionaryByMappingObjects:(id (^)(KeyType key, ObjectType obj))block;


//
// Merging
//

// If both <self> and <dictionary> have entries for a particular key, the entry in <dictionary> will
// take precedence.
- (NSDictionary<KeyType, ObjectType> *)br_dictionaryByAddingEntriesFromDictionary:(NSDictionary<KeyType, ObjectType> *)dictionary;



//
// Descriptions
//

// Generates a concisely formatted description of the dictionary contents on a single line, e.g.
//
// @{@"a": @1, @"b": @2}.br_singleLineDescription => @"{a: 1, b: 2}"
//
- (NSString *)br_singleLineDescription;


@end


@interface NSMutableDictionary<KeyType, ObjectType> (Bedrock)


//
// Removing Entries
//

- (void)br_removeEntriesWhere:(BOOL(^)(KeyType key, ObjectType object))block;


@end

NS_ASSUME_NONNULL_END
