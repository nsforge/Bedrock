//
//  NSData+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Bedrock)


//
// Hexadecimal Conversions
//

// Returns the data as a hex string, with lowercase hexadecimal characters, e.g. "ffff"
- (NSString *)br_hexStringValue;

// Accepts both uppercase and lowercase hexadecimal characters. Will return nil if the
// string has either a non-hexadecimal character, or if the length of the string is not
// an even number (1 byte == 2 hex characters).
+ (nullable instancetype)br_dataWithHexString:(NSString *)hexString;


//
// Crypto
//

- (NSData *)br_MD5Digest;

- (NSData *)br_SHA1Digest;
- (NSData *)br_SHA224Digest;
- (NSData *)br_SHA256Digest;
- (NSData *)br_SHA384Digest;
- (NSData *)br_SHA512Digest;

@end

NS_ASSUME_NONNULL_END
