//
//  NSSet+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet<ObjectType> (Bedrock)


//
// Filtering/Selecting/Finding
//

- (NSSet<ObjectType> *)br_allObjectsWhere:(BOOL (^)(ObjectType obj))block;
- (nullable ObjectType)br_anyObjectWhere:(BOOL (^)(ObjectType obj))block;
- (NSInteger)br_numberOfObjectsWhere:(BOOL (^)(ObjectType obj))block;


//
// Mapping
//

- (NSSet *)br_setByMapping:(nullable id (^)(ObjectType obj))block;


//
// Logic Tests
//

- (BOOL)br_anyObjectPasses:(BOOL (^)(ObjectType obj))block;
- (BOOL)br_allObjectsPass:(BOOL (^)(ObjectType obj))block;


//
// Utilities/Misc/Other
//

- (nullable ObjectType)br_randomObject;


//
// Descriptions
//

// Generates a concisely formatted description of the set contents on a single line, e.g.
//
// @[@1, @2, @3, @4].br_setValue.br_singleLineDescription => @"{1, 2, 3, 4}"
//
- (NSString *)br_singleLineDescription;


@end

@interface NSMutableSet<ObjectType> (Bedrock)


//
// Removing Objects
//

- (void)br_removeObjectsWhere:(BOOL (^)(ObjectType obj))block;

@end


NS_ASSUME_NONNULL_END
