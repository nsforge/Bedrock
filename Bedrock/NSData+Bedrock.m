//
//  NSData+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSData+Bedrock.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Bedrock)

- (NSString *)br_hexStringValue
{
	uint8_t const *bytes = self.bytes;
	NSMutableString *string = [NSMutableString stringWithCapacity:self.length * 2];
	for (NSUInteger i = 0; i < self.length; i++) {
		[string appendFormat:@"%02x", bytes[i]];
	}
	return string.copy;
}

+ (instancetype)br_dataWithHexString:(NSString *)hexString
{
	if (hexString.length % 2 != 0) {
		NSLog(@"Error: attempted to create NSData from hex string with a non-even number of chars");
		return nil;
	}
	
	NSUInteger byteCount = hexString.length / 2;
	NSMutableData *data = [NSMutableData dataWithLength:byteCount];
	for (NSUInteger byteOffset = 0; byteOffset < byteCount; byteOffset++) {
		char singleByteBuffer[3];
		singleByteBuffer[0] = (char)[hexString characterAtIndex:byteOffset * 2];
		singleByteBuffer[1] = (char)[hexString characterAtIndex:byteOffset * 2 + 1];
		singleByteBuffer[2] = 0;
		uint8_t byte = (uint8_t)strtoul(singleByteBuffer, NULL, 16);
		[data replaceBytesInRange:NSMakeRange(byteOffset, 1) withBytes:&byte];
	}
	return data.copy;
}

- (NSData *)br_MD5Digest
{
	uint8_t output[CC_MD5_DIGEST_LENGTH];
	CC_MD5(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:sizeof(output)];
}

- (NSData *)br_SHA1Digest
{
	uint8_t output[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:sizeof(output)];
}

- (NSData *)br_SHA224Digest
{
	uint8_t output[CC_SHA224_DIGEST_LENGTH];
	CC_SHA224(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:sizeof(output)];
}

- (NSData *)br_SHA256Digest
{
	uint8_t output[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:sizeof(output)];
}

- (NSData *)br_SHA384Digest
{
	uint8_t output[CC_SHA384_DIGEST_LENGTH];
	CC_SHA384(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:sizeof(output)];
}

- (NSData *)br_SHA512Digest
{
	uint8_t output[CC_SHA512_DIGEST_LENGTH];
	CC_SHA512(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:sizeof(output)];
}

@end
