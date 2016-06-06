//
//  NSError+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSError+Bedrock.h"

@implementation NSError (Bedrock)

+ (instancetype)br_errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description
{
	return [NSError errorWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey: description}];
}

+ (instancetype)br_errorWithDomain:(NSString *)domain code:(NSInteger)code descriptionFormat:(NSString *)descriptionFormat, ...
{
	va_list argList;
	va_start(argList, descriptionFormat);
	NSString *description = [[NSString alloc] initWithFormat:descriptionFormat arguments:argList];
	va_end(argList);
	return [NSError br_errorWithDomain:domain code:code description:description];
}

@end
