//
//  NSArray+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 14/02/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (Bedrock)


//
// Filtering/Selecting/Finding
//

- (NSArray<ObjectType> *)br_allObjectsWhere:(BOOL (^)(ObjectType obj))block;
- (nullable ObjectType)br_firstObjectWhere:(BOOL (^)(ObjectType obj))block;
- (NSUInteger)br_indexOfFirstObjectWhere:(BOOL (^)(ObjectType obj))block;
- (NSInteger)br_numberOfObjectsWhere:(BOOL (^)(ObjectType obj))block;
- (NSIndexSet *)br_indexesOfObjectsWhere:(BOOL (^)(ObjectType obj))block;

// Returns the indexes of every object that returns YES for [anObj isEqual:object]
- (NSIndexSet *)br_indexesOfObject:(ObjectType)object;


//
// Mapping
//

// Note: nil results won't be added to the returned array.
- (NSArray *)br_arrayByMapping:(nullable id (^)(ObjectType obj))block;


//
// Slicing
//


// NSArray *a = @[@"A", @"B", @"C", @"D", @"E"];
// [a br_subarrayToIndex:2] => @[@"A", @"B"]
// [a br_subarrayFromIndex:2] => @[@"C", @"D", @"E"]

// Returns all objects up to (but not including) <index>
- (NSArray<ObjectType> *)br_subarrayToIndex:(NSUInteger)index;

// Returns all objects from (and including) <index>, to the end of the array
- (NSArray<ObjectType> *)br_subarrayFromIndex:(NSUInteger)index;


//
// Logic Tests
//

- (BOOL)br_anyObjectPasses:(BOOL (^)(ObjectType obj))block;
- (BOOL)br_allObjectsPass:(BOOL (^)(ObjectType obj))block;

- (BOOL)br_allObjectsAreKindOfClass:(Class)klass;


//
// Sorting
//

- (NSArray<ObjectType> *)br_sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending;

// Uses an NSSortDescriptor with "self" as the key
- (NSArray<ObjectType> *)br_sortedArrayAscending:(BOOL)ascending;

//
// Flattening
//

// Flattens arrays in the top level.
// @[@[@1, @2], @[@3, @[@4, @5]]].br_arrayByFlattening => @[@1, @2, @3, @[@4, @5]]
- (NSArray *)br_arrayByFlattening;

// Flattens arrays to <level>.
- (NSArray *)br_arrayByFlatteningToLevel:(NSInteger)level;


//
// Removing Objects
//


- (NSArray<ObjectType> *)br_arrayByRemovingObjectAtIndex:(NSUInteger)index;
- (NSArray<ObjectType> *)br_arrayByRemovingObjectsAtIndexes:(NSIndexSet *)indexes;

// Removes all occurences in the array of the given object.
- (NSArray<ObjectType> *)br_arrayByRemovingObject:(ObjectType)object;

// Will remove duplicate objects (according to -isEqual:), leaving
// the first occurence of any duplicates in the array.
- (NSArray<ObjectType> *)br_arrayByRemovingDuplicateObjects;


//
// Utilities/Misc/Other
//

- (NSSet<ObjectType> *)br_setValue;
- (nullable ObjectType)br_randomObject;


//
// Descriptions
//

// Generates a concisely formatted description of the array contents on a single line, e.g.
//
// @[@1, @2, @3, @4].br_singleLineDescription => @"[1, 2, 3, 4]"
//
- (NSString *)br_singleLineDescription;

@end



@interface NSMutableArray<ObjectType> (Bedrock)


//
// Sorting
//

- (void)br_sortWithKey:(NSString *)key ascending:(BOOL)ascending;


//
// Removing Objects
//

- (void)br_removeObjectsWhere:(BOOL (^)(ObjectType obj))block;

// Removes objects from <index> until the end of the array
- (void)br_removeObjectsFromIndex:(NSUInteger)index;

// Removes objects from the start of the array until the object _before_ <index>
- (void)br_removeObjectsToIndex:(NSUInteger)index;

// Duplicates are determined according to -isEqual:
- (void)br_removeDuplicateObjects;

@end


NS_ASSUME_NONNULL_END
