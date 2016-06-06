//
//  NSAttributedString+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 6/06/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Bedrock;
@import Expecta;

@interface NSAttributedString_BedrockTests : XCTestCase

@end

@implementation NSAttributedString_BedrockTests

- (void)test_stringWithString
{
	NSAttributedString *s = [NSAttributedString br_stringWithString:@"my string"];
	
	expect(s.string).to.equal(@"my string");
	expect([s attributesAtIndex:0 effectiveRange:NULL]).to.equal(@{});
}

- (void)test_stringWithStringAttributes
{
	NSAttributedString *s = [NSAttributedString br_stringWithString:@"a link" attributes:@{NSLinkAttributeName: @"a URL"}];
	
	expect(s.string).to.equal(@"a link");
	expect([s attributesAtIndex:0 effectiveRange:NULL]).to.equal(@{NSLinkAttributeName: @"a URL"});
}

- (void)test_appendString
{
	NSMutableAttributedString *s = [NSMutableAttributedString new];
	[s br_appendString:@"string 1"];
	[s br_appendString:@" string 2"];
	expect(s.string).to.equal(@"string 1 string 2");
	expect([s attributesAtIndex:0 effectiveRange:NULL]).to.equal(@{});
}

- (void)test_appendStringAttributes
{
	NSMutableAttributedString *s = [NSMutableAttributedString new];
	[s br_appendString:@"some text - " attributes:@{}];
	[s br_appendString:@"a link" attributes:@{NSLinkAttributeName: @"a URL"}];
	expect(s.string).to.equal(@"some text - a link");
	expect([s attributesAtIndex:0 effectiveRange:NULL]).to.equal(@{});
	expect([s attributesAtIndex:@"some text - ".length effectiveRange:NULL]).to.equal(@{NSLinkAttributeName: @"a URL"});
}

- (void)test_addAttributes
{
	NSMutableAttributedString *s = [NSMutableAttributedString br_stringWithString:@"a string"];
	[s br_addAttributes:@{NSLinkAttributeName: @"a URL"}];
	expect(s.string).to.equal(@"a string");
	expect([s attributesAtIndex:0 effectiveRange:NULL]).to.equal(@{NSLinkAttributeName: @"a URL"});
}

- (void)test_setAttributes
{
	NSMutableAttributedString *s = [NSMutableAttributedString br_stringWithString:@"a string" attributes:@{NSLinkAttributeName: @"a URL"}];
	[s br_setAttributes:@{NSLinkAttributeName: @"a different URL"}];
	expect(s.string).to.equal(@"a string");
	expect([s attributesAtIndex:0 effectiveRange:NULL]).to.equal(@{NSLinkAttributeName: @"a different URL"});
}

@end
