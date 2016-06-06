//
//  NSString+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSString+Bedrock.h"

@implementation NSString (Bedrock)

- (BOOL)br_containsString:(NSString *)string options:(NSStringCompareOptions)options
{
	return [self rangeOfString:string options:options].location != NSNotFound;
}

- (instancetype)br_stringByRemovingOccurrencesOfString:(NSString *)string
{
	return [self stringByReplacingOccurrencesOfString:string withString:@""];
}

- (instancetype)br_stringByRemovingOccurrencesOfString:(NSString *)string options:(NSStringCompareOptions)options
{
	return [self stringByReplacingOccurrencesOfString:string withString:@"" options:options range:NSMakeRange(0, self.length)];
}

- (NSData *)br_UTF8DataValue
{
	return [self dataUsingEncoding:NSUTF8StringEncoding];
}

+ (instancetype)br_stringWithUTF8Data:(NSData *)data
{
	return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
