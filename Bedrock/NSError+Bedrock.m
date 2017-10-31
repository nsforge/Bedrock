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

+ (instancetype)br_errorWithDomain:(NSString *)domain code:(NSInteger)code underlyingError:(NSError *)underlyingError description:(NSString *)description
{
	return [NSError errorWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey: description, NSUnderlyingErrorKey: underlyingError}];
}

+ (instancetype)br_errorWithDomain:(NSString *)domain code:(NSInteger)code underlyingError:(NSError *)underlyingError descriptionFormat:(NSString *)descriptionFormat, ...
{
	va_list argList;
	va_start(argList, descriptionFormat);
	NSString *description = [[NSString alloc] initWithFormat:descriptionFormat arguments:argList];
	va_end(argList);
	return [self br_errorWithDomain:domain code:code underlyingError:underlyingError description:description];
}

- (NSError *)br_underlyingError
{
	return self.userInfo[NSUnderlyingErrorKey];
}

- (NSString *)br_diagnosticDescription
{
	NSMutableArray<NSString *> *userInfoStrings = [NSMutableArray new];
	for (NSString *aKey in self.userInfo) {
		if ([aKey isEqual:NSLocalizedDescriptionKey]) continue;	// this value will be included outside of the userinfo keys
		id value = self.userInfo[aKey];
		if ([aKey isEqual:NSUnderlyingErrorKey]) {
			value = [NSString stringWithFormat:@"(%@)", [value br_diagnosticDescription]];
		}
		[userInfoStrings addObject:[NSString stringWithFormat:@"%@: %@", aKey, value]];
	}
	NSString *userInfoText = userInfoStrings.count > 0 ? [NSString stringWithFormat:@" {%@}", [userInfoStrings componentsJoinedByString:@", "]] : @"";
	return [NSString stringWithFormat:@"Error %@[%lld] '%@'%@", self.domain, (long long)self.code, self.localizedDescription, userInfoText];
}

@end
