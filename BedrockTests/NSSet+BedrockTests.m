//
//  NSSet+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 6/06/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Expecta;
@import Bedrock;

@interface NSSet_BedrockTests : XCTestCase

@end

@implementation NSSet_BedrockTests

- (void)test_allObjectsWhere
{
	NSSet<NSNumber *> *s = @[@1, @2, @3, @4, @5, @6, @7, @8, @9].br_setValue;
	
	expect([s br_allObjectsWhere:^BOOL(NSNumber *obj) {
		return obj.integerValue % 2 == 0;
	}]).to.equal(@[@2, @4, @6, @8].br_setValue);
}

- (void)test_anyObjectWhere
{
	NSSet<NSNumber *> *s = @[@1, @2, @3, @4, @5, @6, @7, @8, @9].br_setValue;
	
	expect([s br_anyObjectWhere:^BOOL(NSNumber *obj) {
		return obj.integerValue > 8;
	}]).to.equal(@9);
}

- (void)test_numberOfObjectsWhere
{
	NSSet<NSNumber *> *s = @[@1, @2, @3, @4, @5, @6, @7, @8, @9].br_setValue;
	
	expect([s br_numberOfObjectsWhere:^BOOL(NSNumber *obj) {
		return obj.integerValue % 3 == 0; // multiples of 3
	}]).to.equal(3);
}

- (void)test_setByMapping
{
	NSSet<NSNumber *> *s = @[@1, @2, @3].br_setValue;
	
	expect([s br_setByMapping:^id(NSNumber *obj) {
		return @(obj.integerValue * obj.integerValue);
	}]).to.equal(@[@1, @4, @9].br_setValue);
}

- (void)test_anyObjectPasses
{
	NSSet<NSString *> *s = @[@"the", @"quick", @"brown", @"fox"].br_setValue;
	
	expect([s br_anyObjectPasses:^BOOL(NSString *obj) {
		return [obj containsString:@"ox"];
	}]).to.equal(YES);
	expect([s br_anyObjectPasses:^BOOL(NSString *obj) {
		return [obj containsString:@"?"];
	}]).to.equal(NO);
}

- (void)test_allObjectsPass
{
	NSSet<NSString *> *s = @[@"the", @"quick", @"brown", @"fox"].br_setValue;
	
	expect([s br_allObjectsPass:^BOOL(NSString *obj) {
		return obj.length < 10;
	}]).to.equal(YES);
	expect([s br_allObjectsPass:^BOOL(NSString *obj) {
		return [obj containsString:@"o"];
	}]).to.equal(NO);
}

- (void)test_randomObject
{
	NSSet<NSNumber *> *s = @[@1, @2, @3, @4, @5, @6, @7, @8, @9].br_setValue;
	
	NSNumber *randomNumber = s.br_randomObject;
	expect([s containsObject:randomNumber]).to.equal(YES);
}

- (void)test_singleLineDescription
{
	NSSet<NSNumber *> *s = @[@1, @2].br_setValue;
	
	NSString *d = s.br_singleLineDescription;
	expect([d isEqual:@"{1, 2}"] || [d isEqual:@"{2, 1}"]).to.equal(YES);
}

- (void)test_removeObjectsWhere
{
	NSMutableSet<NSNumber *> *s = @[@1, @2, @3, @4, @5, @6, @7, @8, @9].br_setValue.mutableCopy;
	
	[s br_removeObjectsWhere:^BOOL(NSNumber *obj) {
		return obj.integerValue > 4;
	}];
	
	expect(s).to.equal(@[@1, @2, @3, @4].br_setValue);
}

@end
