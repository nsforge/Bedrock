//
//  NSAttributedString+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@interface NSAttributedString (Bedrock)

+ (instancetype)br_stringWithString:(NSString *)string;

+ (instancetype)br_stringWithString:(NSString *)string attributes:(nullable NSDictionary<NSString *, id> *)attributes;

@end


@interface NSMutableAttributedString (Bedrock)

- (void)br_appendString:(NSString *)string;

- (void)br_appendString:(NSString *)string attributes:(nullable NSDictionary<NSString *, id> *)attributes;

// Adds the attributes to the entire range of the string.
- (void)br_addAttributes:(NSDictionary<NSString *, id> *)attributes;

// Sets the attributes (replacing any existing attributes) for the entire range of the string.
- (void)br_setAttributes:(nullable NSDictionary<NSString *, id> *)attributes;

@end


NS_ASSUME_NONNULL_END
