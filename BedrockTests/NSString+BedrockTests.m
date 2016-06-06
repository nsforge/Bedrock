//
//  NSString+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 6/06/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Bedrock;
@import Expecta;

@interface NSString_BedrockTests : XCTestCase

@end

@implementation NSString_BedrockTests

- (void)test_containsStringOptions
{
	NSString *s = @"the quick brown fox";
	
	expect([s br_containsString:@"FOX" options:NSCaseInsensitiveSearch]).to.equal(YES);
	expect([s br_containsString:@"FOX" options:(NSStringCompareOptions)0]).to.equal(NO);
}

- (void)test_stringByRemovingOccurrencesOfString
{
	NSString *s = @"the quick brown fox";
	
	expect([s br_stringByRemovingOccurrencesOfString:@"fox"]).to.equal(@"the quick brown ");
	expect([s br_stringByRemovingOccurrencesOfString:@"FOX"]).to.equal(@"the quick brown fox");
}

- (void)test_stringByRemovingOccurrencesOfStringOptions
{
	NSString *s = @"the quick brown fox";
	
	expect([s br_stringByRemovingOccurrencesOfString:@"fox" options:NSCaseInsensitiveSearch]).to.equal(@"the quick brown ");
	expect([s br_stringByRemovingOccurrencesOfString:@"FOX" options:NSCaseInsensitiveSearch]).to.equal(@"the quick brown ");
}

@end
