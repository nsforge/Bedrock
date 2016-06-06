//
//  NSAttributedString+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSAttributedString+Bedrock.h"

@implementation NSAttributedString (Bedrock)

+ (instancetype)br_stringWithString:(NSString *)string
{
	return [[self alloc] initWithString:string];
}

+ (instancetype)br_stringWithString:(NSString *)string attributes:(NSDictionary<NSString *,id> *)attributes
{
	return [[self alloc] initWithString:string attributes:attributes];
}

@end


@implementation NSMutableAttributedString (Bedrock)

- (void)br_appendString:(NSString *)string
{
	[self appendAttributedString:[NSAttributedString br_stringWithString:string]];
}

- (void)br_appendString:(NSString *)string attributes:(nullable NSDictionary<NSString *, id> *)attributes
{
	[self appendAttributedString:[NSAttributedString br_stringWithString:string attributes:attributes]];
}

- (void)br_addAttributes:(NSDictionary<NSString *, id> *)attributes
{
	[self addAttributes:attributes range:NSMakeRange(0, self.length)];
}

- (void)br_setAttributes:(nullable NSDictionary<NSString *, id> *)attributes
{
	[self setAttributes:attributes range:NSMakeRange(0, self.length)];
}

@end
