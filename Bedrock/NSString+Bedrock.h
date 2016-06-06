//
//  NSString+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Bedrock)


//
// Logic Tests
//

- (BOOL)br_containsString:(NSString *)string options:(NSStringCompareOptions)options;


//
// Manipulation
//

- (instancetype)br_stringByRemovingOccurrencesOfString:(NSString *)string;
- (instancetype)br_stringByRemovingOccurrencesOfString:(NSString *)string options:(NSStringCompareOptions)options;


//
// Binary Conversion
//

- (nullable NSData *)br_UTF8DataValue;

+ (nullable instancetype)br_stringWithUTF8Data:(NSData *)data;

@end


NS_ASSUME_NONNULL_END
