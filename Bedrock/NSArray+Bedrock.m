//
//  NSArray+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 14/02/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSArray+Bedrock.h"
#import "BedrockMacros.h"

@implementation NSArray (Bedrock)

- (NSArray *)br_allObjectsWhere:(BOOL (^)(id _Nonnull))block
{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
	for (id anObj in self) {
		if (block(anObj)) {
			[result addObject:anObj];
		}
	}
	return result.copy;
}

- (id)br_firstObjectWhere:(BOOL (^)(id _Nonnull))block
{
	for (id anObj in self) {
		if (block(anObj)) {
			return anObj;
		}
	}
	return nil;
}

- (NSUInteger)br_indexOfFirstObjectWhere:(BOOL (^)(id _Nonnull))block
{
	NSUInteger i = 0;
	for (id anObj in self) {
		if (block(anObj)) {
			return i;
		}
		i++;
	}
	return NSNotFound;
}

- (NSInteger)br_numberOfObjectsWhere:(BOOL (^)(id _Nonnull))block
{
	NSInteger number = 0;
	for (id anObj in self) {
		if (block(anObj)) {
			number++;
		}
	}
	return number;
}

- (NSIndexSet *)br_indexesOfObjectsWhere:(BOOL (^)(id obj))block
{
	return [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
		return block(obj);
	}];
}

- (NSIndexSet *)br_indexesOfObject:(id)object
{
	return [self br_indexesOfObjectsWhere:^BOOL(id obj) {
		return [obj isEqual:object];
	}];
}

- (NSArray *)br_arrayByMapping:(id (^)(id))block
{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
	for (id anObj in self) {
		id mappedObj = block(anObj);
		if (mappedObj != nil) {
			[result addObject:mappedObj];
		}
	}
	return result.copy;
}

- (NSArray *)br_subarrayToIndex:(NSUInteger)index
{
	return [self subarrayWithRange:NSMakeRange(0, index)];
}

- (NSArray *)br_subarrayFromIndex:(NSUInteger)index
{
	return [self subarrayWithRange:NSMakeRange(index, self.count - index)];
}

- (BOOL)br_anyObjectPasses:(BOOL (^)(id _Nonnull))block
{
	for (id anObj in self) {
		if (block(anObj)) {
			return YES;
		}
	}
	return NO;
}

- (BOOL)br_allObjectsPass:(BOOL (^)(id _Nonnull))block
{
	for (id anObj in self) {
		if (block(anObj) == NO) {
			return NO;
		}
	}
	return YES;
}

- (BOOL)br_allObjectsAreKindOfClass:(Class)klass
{
	return [self br_allObjectsPass:^BOOL(id obj) {
		return [obj isKindOfClass:klass];
	}];
}

- (NSArray *)br_sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending
{
	return [self sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]]];
}

- (NSArray *)br_sortedArrayAscending:(BOOL)ascending
{
	return [self sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:SelfKey(self) ascending:ascending]]];
}

- (NSArray *)br_arrayByFlattening
{
	return [self br_arrayByFlatteningToLevel:1];
}

- (NSArray *)br_arrayByFlatteningToLevel:(NSInteger)level
{
	if (level == 0) return self;
	
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
	for (id anObj in self) {
		NSArray *objAsArray = AsClass(anObj, NSArray);
		if (objAsArray != nil) {
			[result addObjectsFromArray:[objAsArray br_arrayByFlatteningToLevel:level - 1]];
		} else {
			[result addObject:anObj];
		}
	}
	return result.copy;
}

- (NSArray *)br_arrayByRemovingObjectAtIndex:(NSUInteger)index
{
	return [self br_arrayByRemovingObjectsAtIndexes:[NSIndexSet indexSetWithIndex:index]];
}

- (NSArray *)br_arrayByRemovingObjectsAtIndexes:(NSIndexSet *)indexes
{
	NSMutableArray *result = self.mutableCopy;
	[result removeObjectsAtIndexes:indexes];
	return result.copy;
}

- (NSArray *)br_arrayByRemovingObject:(id)object
{
	return [self br_arrayByRemovingObjectsAtIndexes:[self br_indexesOfObject:object]];
}

- (NSArray *)br_arrayByRemovingDuplicateObjects
{
	NSMutableArray *result = self.mutableCopy;
	[result br_removeDuplicateObjects];
	return result.copy;
}

- (NSSet *)br_setValue
{
	return [[NSSet alloc] initWithArray:self];
}

- (id)br_randomObject
{
	if (self.count == 0) {
		return nil;
	}
	return self[arc4random() % self.count];
}

- (NSString *)br_singleLineDescription
{
	NSArray<NSString *> *descriptions = [self br_arrayByMapping:^id(id obj) { return [obj description]; }];
	return [NSString stringWithFormat:@"[%@]", [descriptions componentsJoinedByString:@", "]];
}

@end


@implementation NSMutableArray (Bedrock)

- (void)br_sortWithKey:(NSString *)key ascending:(BOOL)ascending
{
	[self sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]]];
}

- (void)br_removeObjectsWhere:(BOOL (^)(id obj))block
{
	[self removeObjectsAtIndexes:[self br_indexesOfObjectsWhere:block]];
}

- (void)br_removeObjectsFromIndex:(NSUInteger)index
{
	[self removeObjectsInRange:NSMakeRange(index, self.count - index)];
}

- (void)br_removeObjectsToIndex:(NSUInteger)index
{
	[self removeObjectsInRange:NSMakeRange(0, index)];
}

- (void)br_removeDuplicateObjects
{
	NSMutableSet *existingObjects = [NSMutableSet new];
	NSMutableIndexSet *indexesToRemove = [NSMutableIndexSet new];
	[self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([existingObjects containsObject:obj]) {
			[indexesToRemove addIndex:idx];
		} else {
			[existingObjects addObject:obj];
		}
	}];
	[self removeObjectsAtIndexes:indexesToRemove];
}

@end
