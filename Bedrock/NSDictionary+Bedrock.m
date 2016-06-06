//
//  NSDictionary+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSDictionary+Bedrock.h"

@implementation NSDictionary (Bedrock)

- (NSDictionary *)br_allEntriesWhere:(BOOL (^)(id, id))block
{
	NSMutableDictionary *result = self.mutableCopy;
	[result br_removeEntriesWhere:^BOOL(id key, id object) {
		return block(key, object) == NO;
	}];
	return result.copy;
}

- (NSArray *)br_arrayByMapping:(id (^)(id, id))block
{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		id mappedObject = block(key, obj);
		if (mappedObject != nil) {
			[result addObject:mappedObject];
		}
	}];
	return result.copy;
}

- (NSDictionary *)br_dictionaryByMappingObjects:(id (^)(id, id))block
{
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		id mappedObject = block(key, obj);
		if (mappedObject != nil) {
			[result setObject:mappedObject forKey:key];
		}
	}];
	return result.copy;
}

- (NSDictionary *)br_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary
{
	NSMutableDictionary *result = self.mutableCopy;
	[dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[result setObject:obj forKey:key];
	}];
	return result.copy;
}

- (NSString *)br_singleLineDescription
{
	NSArray<NSString *> *entryDescriptions = [self br_arrayByMapping:^id (id key, id obj) {
		return [NSString stringWithFormat:@"%@: %@", key, obj];
	}];
	return [NSString stringWithFormat:@"{%@}", [entryDescriptions componentsJoinedByString:@", "]];
}

@end


@implementation NSMutableDictionary (Bedrock)

- (void)br_removeEntriesWhere:(BOOL (^)(id, id))block
{
	NSMutableArray *keysToRemove = [NSMutableArray new];
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		if (block(key, obj)) {
			[keysToRemove addObject:key];
		}
	}];
	[self removeObjectsForKeys:keysToRemove];
}

@end
