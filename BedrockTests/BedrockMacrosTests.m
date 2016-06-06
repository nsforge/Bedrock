//
//  BedrockMacrosTests.m
//  Bedrock
//
//  Created by Nick Forge on 15/02/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Bedrock;
@import Expecta;

@interface BedrockMacrosTests : XCTestCase

@end

@implementation BedrockMacrosTests

- (void)test_AsClass
{
	id x = @"a string";
	NSNumber *xAsNumber = AsClass(x, NSNumber);
	NSString *xAsString = AsClass(x, NSString);
	expect(xAsNumber).to.beNil;
	expect(xAsString).to.equal(x);
}

- (void)test_asProtocol
{
	id x = @"a string";
	id<NSCopying> xAsNSCopying = AsProtocol(x, NSCopying);
	id<NSDiscardableContent> xAsDiscardableContent = AsProtocol(x, NSDiscardableContent);
	
	expect(xAsNSCopying).to.equal(x);
	expect(xAsDiscardableContent).to.beNil;
}

- (void)test_Key
{
	NSString *stringLengthKey = Key(NSString, length);
	expect(stringLengthKey).to.equal(@"length");
	
	NSString *arrayCountKey = Key(NSArray, count);
	expect(arrayCountKey).to.equal(@"count");
}

- (void)test_SelfKey
{
	// this is a key on XCTestCase, which is <self> in this context
	NSString *continueAfterFailureKey = SelfKey(continueAfterFailure);
	expect(continueAfterFailureKey).to.equal(@"continueAfterFailure");
}

- (void)test_InstanceKey
{
	NSArray *array = @[@1, @2, @3];
	NSString *countKey = InstanceKey(array, count);
	expect(countKey).to.equal(@"count");
}

- (void)test_ObjectsAreEqual
{
	id a = nil;
	id b = nil;
	id c = @"a string";
	id d = @"a string";
	
	expect(ObjectsAreEqual(a, b)).to.equal(YES);
	expect(ObjectsAreEqual(a, c)).to.equal(NO);
	expect(ObjectsAreEqual(c, a)).to.equal(NO);
	expect(ObjectsAreEqual(c, d)).to.equal(YES);
}

@end
