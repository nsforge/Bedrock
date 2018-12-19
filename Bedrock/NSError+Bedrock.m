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

static NSUInteger const br_NSErrorDiagnosticDescriptionIndentation = 4;

- (NSString *)br_diagnosticDescription
{
	return [self br_diagnosticDescriptionWithIndentation:0];
}

- (NSString *)br_diagnosticDescriptionWithIndentation:(NSUInteger)indentation
{
	NSString *indentationString = [@"" stringByPaddingToLength:indentation withString:@" " startingAtIndex:0];
	NSString *childIndentationString = [@"" stringByPaddingToLength:indentation + br_NSErrorDiagnosticDescriptionIndentation withString:@" " startingAtIndex:0];
	NSMutableArray<NSString *> *userInfoStrings = [NSMutableArray new];
	NSString *underlyingErrorInfoString = nil;
	for (NSString *aKey in self.userInfo) {
		if ([aKey isEqual:NSLocalizedDescriptionKey]) continue;    // this value will be included outside of the userinfo keys
		id value = self.userInfo[aKey];
		if ([aKey isEqual:NSUnderlyingErrorKey]) {
			value = [NSString stringWithFormat:@"%@", [value br_diagnosticDescriptionWithIndentation:indentation + br_NSErrorDiagnosticDescriptionIndentation]];
			underlyingErrorInfoString = [NSString stringWithFormat:@"underlyingError: %@", value];
		} else {
			[userInfoStrings addObject:[NSString stringWithFormat:@"%@: %@", aKey, value]];
		}
	}
	if (underlyingErrorInfoString) [userInfoStrings addObject:underlyingErrorInfoString];
	
	NSString *userInfoText = @"";
	if (userInfoStrings.count > 0) {
		NSMutableArray<NSString *> *lines = [NSMutableArray new];
		for (NSString *aString in userInfoStrings) {
			[lines addObject:[NSString stringWithFormat:@"%@%@", childIndentationString, aString]];
		}
		userInfoText = [NSString stringWithFormat:@" {\n%@\n%@}", [lines componentsJoinedByString:@"\n"], indentationString];
	}
	return [NSString stringWithFormat:@"%@:%lld '%@'%@", self.domain, (long long)self.code, self.localizedDescription, userInfoText];
}

@end
