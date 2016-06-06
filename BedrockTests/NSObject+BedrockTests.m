//
//  NSObject+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 6/06/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Bedrock;
@import Expecta;

@interface Person : NSObject

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) NSInteger age; // in years

@property (nonatomic, strong, readwrite) NSArray<NSString *> *friendNames;

@end

@implementation Person

- (NSString *)description
{
	return [self br_descriptionWithKeys:@[SelfKey(name), SelfKey(age), @{@"numberOfFriends": @(self.friendNames.count)}]];
}

- (NSString *)structDescription
{
	return [self br_structDescriptionWithKeys:@[SelfKey(name), SelfKey(age), @{@"numberOfFriends": @(self.friendNames.count)}]];
}

@end


@interface NSObject_BedrockTests : XCTestCase

@end

@implementation NSObject_BedrockTests

- (void)test_descriptionWithKeys
{
	Person *p = [Person new];
	p.name = @"Rick";
	p.age = 60;
	p.friendNames = @[@"Morty", @"Summer"];
	
	NSString *description = p.description;
	
	expect([description hasPrefix:@"<Person: "]).to.equal(YES);
	expect([description hasSuffix:@"{ name: \"Rick\", age: 60, numberOfFriends: 2 }>"]).to.equal(YES);
}

- (void)test_structDescriptionWithKeys
{
	Person *p = [Person new];
	p.name = @"Rick";
	p.age = 60;
	p.friendNames = @[@"Morty", @"Summer"];
	
	expect(p.structDescription).to.equal(@"{name: \"Rick\", age: 60, numberOfFriends: 2}");
}

@end
