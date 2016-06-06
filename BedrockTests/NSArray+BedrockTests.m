//
//  NSArray+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 15/02/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Bedrock;
@import Expecta;

@interface NSArray_BedrockTests : XCTestCase

@end

@implementation NSArray_BedrockTests

- (void)test_allObjectsWhere
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_allObjectsWhere:^BOOL(NSString *s) { return s.length == 3; }]).to.equal(@[@"the", @"fox"]);
}

- (void)test_firstObjectWhere
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_firstObjectWhere:^BOOL(NSString *s) { return [s containsString:@"q"]; }]).to.equal(@"quick");
	expect([a br_firstObjectWhere:^BOOL(NSString *s) { return [s containsString:@"j"]; }]).to.beNil;
}

- (void)test_indexOfFirstObjectWhere
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_indexOfFirstObjectWhere:^BOOL(NSString *s) { return [s containsString:@"q"]; }]).to.equal(1);
	expect([a br_indexOfFirstObjectWhere:^BOOL(NSString *s) { return [s containsString:@"j"]; }]).to.equal(NSNotFound);
}

- (void)test_numberOfObjectsWhere
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_numberOfObjectsWhere:^BOOL(NSString *s) { return s.length == 3; }]).to.equal(2);
	expect([a br_numberOfObjectsWhere:^BOOL(NSString *s) { return s.length == 4; }]).to.equal(0);
}

- (void)test_indexesOfObjectsWhere
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_indexesOfObjectsWhere:^BOOL(NSString *s) {
		return [s containsString:@"qui"];
	}]).to.equal([NSIndexSet indexSetWithIndex:1]);
	expect([a br_indexesOfObjectsWhere:^BOOL(NSString *s) {
		return [s isEqual:@"the"];
	}]).to.equal([NSIndexSet indexSetWithIndex:0]);
}

- (void)test_indexesOfObject
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_indexesOfObject:@"the"]).to.equal([NSIndexSet indexSetWithIndex:0]);
	expect([a br_indexesOfObject:@"fox"]).to.equal([NSIndexSet indexSetWithIndex:3]);
	expect([a br_indexesOfObject:@"jumps"]).to.equal([NSIndexSet new]);
}

- (void)test_arrayByMapping
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_arrayByMapping:^id (NSString *s) { return @(s.length); }]).to.equal(@[@3, @5, @5, @3]);
	expect([a br_arrayByMapping:^id (NSString *s) {
		if ([s containsString:@"o"]) {
			return s.uppercaseString;
		}
		return nil;
	}]).to.equal(@[@"BROWN", @"FOX"]);
}

- (void)test_subarrayToIndex
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_subarrayToIndex:1]).to.equal(@[@"the"]);
	expect([a br_subarrayToIndex:2]).to.equal(@[@"the", @"quick"]);
}

- (void)test_subarrayFromIndex
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_subarrayFromIndex:1]).to.equal(@[@"quick", @"brown", @"fox"]);
	expect([a br_subarrayFromIndex:2]).to.equal(@[@"brown", @"fox"]);
}

- (void)test_anyObjectPasses
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_anyObjectPasses:^BOOL(NSString *s) { return [s containsString:@"ox"]; }]).to.equal(YES);
	expect([a br_anyObjectPasses:^BOOL(NSString *s) { return [s containsString:@"they"]; }]).to.equal(NO);
	expect([a br_anyObjectPasses:^BOOL(NSString *s) { return [s containsString:@"bro"]; }]).to.equal(YES);
}

- (void)test_allObjectsPass
{
	NSArray<NSString *> *a = @[@"the", @"quick", @"brown", @"fox"];
	
	expect([a br_allObjectsPass:^BOOL(NSString *s) { return s.length < 10; }]).to.equal(YES);
	expect([a br_allObjectsPass:^BOOL(NSString *s) { return [s containsString:@"e"]; }]).to.equal(NO);
	expect([a br_allObjectsPass:^BOOL(NSString *s) { return [s isKindOfClass:NSString.class]; }]).to.equal(YES);
}

- (void)test_allObjectsAreKindOfClass
{
	NSArray *a1 = @[@1, @2, @"3", NSNull.null];
	NSArray *a2 = @[@1, @2, @3, @4];
	
	expect([a1 br_allObjectsAreKindOfClass:NSObject.class]).to.equal(YES);
	expect([a1 br_allObjectsAreKindOfClass:NSNumber.class]).to.equal(NO);
	expect([a2 br_allObjectsAreKindOfClass:NSNumber.class]).to.equal(YES);
}

- (void)test_sortedArrayWithKeyAscending
{
	NSArray<NSString *> *a = @[@"a", @"ccc", @"bb", @"eeeee", @"dddd"];
	
	NSString *lengthKey = Key(NSString, length);
	expect([a br_sortedArrayWithKey:lengthKey ascending:YES]).to.equal(@[@"a", @"bb", @"ccc", @"dddd", @"eeeee"]);
	expect([a br_sortedArrayWithKey:lengthKey ascending:NO]).to.equal(@[@"eeeee", @"dddd", @"ccc", @"bb", @"a"]);
}

- (void)test_sortedArrayAscending
{
	NSArray<NSString *> *a = @[@"a", @"c", @"b", @"e", @"d"];
	
	expect([a br_sortedArrayAscending:YES]).to.equal(@[@"a", @"b", @"c", @"d", @"e"]);
	expect([a br_sortedArrayAscending:NO]).to.equal(@[@"e", @"d", @"c", @"b", @"a"]);
}

- (void)test_arrayByFlattening
{
	NSArray *a = @[@[@1, @2], @[@3, @[@4, @5]]];
	
	expect([a br_arrayByFlattening]).to.equal(@[@1, @2, @3, @[@4, @5]]);
}

- (void)test_arrayByFlatteningToLevel
{
	NSArray *a = @[@[@1, @2], @[@3, @[@4, @5]]];
	
	expect([a br_arrayByFlatteningToLevel:0]).to.equal(@[@[@1, @2], @[@3, @[@4, @5]]]);
	expect([a br_arrayByFlatteningToLevel:1]).to.equal(@[@1, @2, @3, @[@4, @5]]);
	expect([a br_arrayByFlatteningToLevel:2]).to.equal(@[@1, @2, @3, @4, @5]);
	expect([a br_arrayByFlatteningToLevel:3]).to.equal(@[@1, @2, @3, @4, @5]);
}

- (void)test_arrayByRemovingObjectAtIndex
{
	NSArray *a = @[@1, @2, @3, @4, @5];
	
	expect([a br_arrayByRemovingObjectAtIndex:2]).to.equal(@[@1, @2, @4, @5]);
}

- (void)test_arrayByRemovingObjectsAtIndexes
{
	NSArray *a = @[@1, @2, @3, @4, @5];
	
	NSMutableIndexSet *indexes = [NSMutableIndexSet new];
	[indexes addIndex:1];
	[indexes addIndex:2];
	
	expect([a br_arrayByRemovingObjectsAtIndexes:indexes]).to.equal(@[@1, @4, @5]);
}

- (void)test_arrayByRemovingObject
{
	NSArray *a = @[@1, @2, @3, @1, @2, @3];
	
	expect([a br_arrayByRemovingObject:@1]).to.equal(@[@2, @3, @2, @3]);
}

- (void)test_arrayByRemovingDuplicateObjects
{
	NSArray *a = @[@1, @2, @3, @1, @2, @3];
	expect([a br_arrayByRemovingDuplicateObjects]).to.equal(@[@1, @2, @3]);
}

- (void)test_setValue
{
	NSArray *a = @[@1, @2, @3, @1, @2, @3];
	
	expect(a.br_setValue).to.equal([NSSet setWithObjects:@1, @2, @3, nil]);
}

- (void)test_randomObject
{
	NSArray *a = @[@1, @2, @3, @1, @2, @3];
	
	id randomObject = a.br_randomObject;
	expect(randomObject).to.beKindOf(NSNumber.class);
	expect([a containsObject:randomObject]).to.equal(YES);
}

- (void)test_singleLineDescription
{
	NSArray *a = @[@1, @2, @"3", @4];
	
	expect(a.br_singleLineDescription).to.equal(@"[1, 2, 3, 4]");
}

- (void)test_sortWithKeyAscending
{
	NSMutableArray<NSString *> *a = @[@"a", @"array", @"of", @"strings"].mutableCopy;
	[a br_sortWithKey:Key(NSString, length) ascending:YES];
	expect(a).to.equal(@[@"a", @"of", @"array", @"strings"]);
}

- (void)test_removeObjectsWhere
{
	NSMutableArray<NSNumber *> *a = @[@1, @2, @3, @4, @5, @6, @7, @8, @9].mutableCopy;
	[a br_removeObjectsWhere:^BOOL(NSNumber *obj) { return obj.integerValue % 3 != 0; }];
	expect(a).to.equal(@[@3, @6, @9]);
}

- (void)test_removeObjectsFromIndex
{
	NSMutableArray<NSNumber *> *a = @[@1, @2, @3, @4, @5].mutableCopy;
	[a br_removeObjectsFromIndex:2];
	expect(a).to.equal(@[@1, @2]);
}

- (void)test_removeObjectsToIndex
{
	NSMutableArray<NSNumber *> *a = @[@1, @2, @3, @4, @5].mutableCopy;
	[a br_removeObjectsToIndex:2];
	expect(a).to.equal(@[@3, @4, @5]);
}

- (void)test_removeDuplicateObjects
{
	NSMutableArray *a = @[@1, @2, @3, @1, @2, @3, @1, @2, @3].mutableCopy;
	[a br_removeDuplicateObjects];
	expect(a).to.equal(@[@1, @2, @3]);
}

@end
