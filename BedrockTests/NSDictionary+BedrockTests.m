//
//  NSDictionary+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 6/06/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Bedrock;
@import Expecta;

@interface NSDictionary_BedrockTests : XCTestCase

@end

@implementation NSDictionary_BedrockTests

- (void)test_allEntriesWhere
{
	NSDictionary<NSString *, NSNumber *> *ages = @{
		@"Rick": @60,
		@"Morty": @14,
		@"Beth": @34,
		@"Jerry": @35,
		@"Summer": @17,
	};
	
	expect([ages br_allEntriesWhere:^BOOL(NSString *name, NSNumber *age) {
		return age.integerValue > 40;
	}].allKeys).to.equal(@[@"Rick"]);
}

- (void)test_arrayByMapping
{
	NSDictionary<NSString *, NSNumber *> *ages = @{
		@"Rick": @60,
		@"Morty": @14,
		@"Beth": @34,
		@"Jerry": @35,
		@"Summer": @17,
	};
	
	NSArray<NSString *> *ageStringsOfPeopleOver40 = [ages br_arrayByMapping:^id(NSString *name, NSNumber *age) {
		if (age.integerValue >= 40) {
			return [NSString stringWithFormat:@"%@ - %@", name, age];
		} else {
			return nil;
		}
	}];
	expect(ageStringsOfPeopleOver40).to.equal(@[@"Rick - 60"]);
}

- (void)test_dictionaryByMappingObjects
{
	NSDictionary<NSString *, NSNumber *> *ages = @{
		@"Rick": @60,
		@"Morty": @14,
		@"Beth": @34,
		@"Jerry": @35,
		@"Summer": @17,
	};
	
	NSDictionary<NSString *, NSString *> *ageStrings = [ages br_dictionaryByMappingObjects:^id _Nonnull(NSString *name, NSNumber *age) {
		return [NSString stringWithFormat:@"%@ - %@", name, age];
	}];
	
	expect(ageStrings[@"Morty"]).to.equal(@"Morty - 14");
}

- (void)test_dictionaryByAddingEntriesFromDictionary
{
	NSDictionary *d = @{@"a": @1, @"b": @2};
	
	expect([d br_dictionaryByAddingEntriesFromDictionary:@{@"b": @10, @"c": @11}]).to.equal(@{@"a": @1, @"b": @10, @"c": @11});
}

- (void)test_singleLineDescription
{
	NSDictionary *d = @{@"a": @1, @"b": @2};
	
	// Since NSDictionary is unordered, we'll test that it is one of every possible legitimate result
	NSString *descr = d.br_singleLineDescription;
	expect([descr isEqual:@"{a: 1, b: 2}"] || [descr isEqual:@"{b: 2, a: 1}"]).to.equal(YES);
}

- (void)test_removeEntriesWhere
{
	NSMutableDictionary<NSString *, NSNumber *> *ages = @{
		@"Rick": @60,
		@"Morty": @14,
		@"Beth": @34,
		@"Jerry": @35,
		@"Summer": @17,
	}.mutableCopy;
	
	[ages br_removeEntriesWhere:^BOOL(NSString *name, NSNumber *age) {
		return age.integerValue > 30;
	}];
	
	expect([ages.allKeys br_sortedArrayAscending:YES]).to.equal(@[@"Morty", @"Summer"]);
}

@end
