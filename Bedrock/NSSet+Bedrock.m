//
//  NSSet+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSSet+Bedrock.h"
#import "NSArray+Bedrock.h"

@implementation NSSet (Bedrock)

- (NSSet *)br_allObjectsWhere:(BOOL (^)(id _Nonnull))block
{
	NSMutableSet *result = [NSMutableSet new];
	for (id obj in self) {
		if (block(obj)) {
			[result addObject:obj];
		}
	}
	return result.copy;
}

- (id)br_anyObjectWhere:(BOOL (^)(id _Nonnull))block
{
	for (id obj in self) {
		if (block(obj)) {
			return obj;
		}
	}
	return nil;
}

- (NSInteger)br_numberOfObjectsWhere:(BOOL (^)(id _Nonnull))block
{
	NSInteger count = 0;
	for (id obj in self) {
		if (block(obj)) {
			count += 1;
		}
	}
	return count;
}

- (NSSet *)br_setByMapping:(id  _Nonnull (^)(id _Nonnull))block
{
	NSMutableSet *result = [NSMutableSet new];
	for (id obj in self) {
		id mappedObj = block(obj);
		if (mappedObj != nil) {
			[result addObject:mappedObj];
		}
	}
	return result.copy;
}

- (BOOL)br_anyObjectPasses:(BOOL (^)(id _Nonnull))block
{
	for (id obj in self) {
		if (block(obj)) {
			return YES;
		}
	}
	return NO;
}

- (BOOL)br_allObjectsPass:(BOOL (^)(id _Nonnull))block
{
	for (id obj in self) {
		if (block(obj) == NO) {
			return NO;
		}
	}
	return YES;
}

- (id)br_randomObject
{
	return self.allObjects.br_randomObject;
}

- (NSString *)br_singleLineDescription
{
	NSArray<NSString *> *descriptions = [self.allObjects br_arrayByMapping:^id(id obj) { return [obj description]; }];
	return [NSString stringWithFormat:@"{%@}", [descriptions componentsJoinedByString:@", "]];
}

@end

@implementation NSMutableSet (Bedrock)

- (void)br_removeObjectsWhere:(BOOL (^)(id _Nonnull))block
{
	NSMutableSet *objectsToRemove = [NSMutableSet new];
	for (id obj in self) {
		if (block(obj)) {
			[objectsToRemove addObject:obj];
		}
	}
	[self minusSet:objectsToRemove];
}

@end