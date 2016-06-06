//
//  NSData+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 24/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Bedrock;
@import Expecta;

@interface NSData_Bedrock : XCTestCase

@end

@implementation NSData_Bedrock

- (void)test_hexStringValue
{
	uint64_t number = 123456789123456789;
	NSData *data = [NSData dataWithBytes:&number length:sizeof(number)];
	expect(data.description).to.equal(@"<155fd0ac 4b9bb601>");
	expect(data.br_hexStringValue).to.equal(@"155fd0ac4b9bb601");
}

- (void)test_dataWithHexString
{
	NSData *data;
	uint64_t number;
	
	number = 0;
	data = [NSData br_dataWithHexString:@"155fd0ac4b9bb601"];
	expect(data.description).to.equal(@"<155fd0ac 4b9bb601>");
	[data getBytes:&number length:sizeof(number)];
	expect(number).to.equal(123456789123456789);
	
	number = 0;
	data = [NSData br_dataWithHexString:@"ffff"];
	expect(data.description).to.equal(@"<ffff>");
	[data getBytes:&number length:2];
	expect(number).to.equal(65535);
}

- (void)test_MD5Digest
{
	NSString *testString = @"my test data";
	expect(testString.br_UTF8DataValue.br_MD5Digest.br_hexStringValue).to.equal(@"ca9b0af54979a5b08cdb922383218c52");
}

- (void)test_SHA1Digest
{
	NSString *testString = @"my test data";
	expect(testString.br_UTF8DataValue.br_SHA1Digest.br_hexStringValue).to.equal(@"e878502b17756185fece0459c6bc8f53bec7e3df");
}

- (void)test_SHA224Digest
{
	NSString *testString = @"my test data";
	expect(testString.br_UTF8DataValue.br_SHA224Digest.br_hexStringValue).to.equal(@"b6c5b2341f5f2acc4539d7c16e6498becd74e16bbfed9aff7078178e");
}

- (void)test_SHA256Digest
{
	NSString *testString = @"my test data";
	expect(testString.br_UTF8DataValue.br_SHA256Digest.br_hexStringValue).to.equal(@"8352f5962a8bb52aca2c0eaec8cf56623f7b1dbfd899270a6747b6873a8d429f");
}

- (void)test_SHA384Digest
{
	NSString *testString = @"my test data";
	expect(testString.br_UTF8DataValue.br_SHA384Digest.br_hexStringValue).to.equal(@"0c254c151e2aac2468a5d42c87e0fea3b60db5a42922a9e629fb6d3508f5fa8daa0bcbadac1bfd5929b23ef65fd09fec");
}

- (void)test_SHA512Digest
{
	NSString *testString = @"my test data";
	expect(testString.br_UTF8DataValue.br_SHA512Digest.br_hexStringValue).to.equal(@"d4aa1703c638d0df8540acfacca32bde9db32ef428135e614a81e5c09e3643b13f5245a72418cd6852eb73bfa7ecf754810f4c4694e36a48fc770115322d009b");
}

@end
