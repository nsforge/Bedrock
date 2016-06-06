//
//  NSError+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 6/06/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Expecta;
@import Bedrock;

@interface NSError_BedrockTests : XCTestCase

@end

@implementation NSError_BedrockTests

- (void)test_errorWithDomainCodeDescription
{
	NSError *error = [NSError br_errorWithDomain:@"Domain" code:123 description:@"An error occurred"];
	expect(error).to.equal([[NSError alloc] initWithDomain:@"Domain" code:123 userInfo:@{NSLocalizedDescriptionKey: @"An error occurred"}]);
}

- (void)test_errorWithDomainCodeDescriptionFormat
{
	NSInteger problemCount = 5;
	NSError *error = [NSError br_errorWithDomain:@"Domain" code:123 descriptionFormat:@"%d things went wrong", problemCount];
	expect(error).to.equal([[NSError alloc] initWithDomain:@"Domain" code:123 userInfo:@{NSLocalizedDescriptionKey: @"5 things went wrong"}]);
}

@end
