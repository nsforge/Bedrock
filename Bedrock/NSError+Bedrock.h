//
//  NSError+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (Bedrock)

// In the following methods, <description>/<descriptionFormat> are used as the value for NSLocalizedDescriptionKey
// in the error's userInfo.
+ (instancetype)br_errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description;
+ (instancetype)br_errorWithDomain:(NSString *)domain code:(NSInteger)code descriptionFormat:(NSString *)descriptionFormat, ...;

+ (instancetype)br_errorWithDomain:(NSString *)domain code:(NSInteger)code underlyingError:(NSError *)underlyingError description:(NSString *)description;
+ (instancetype)br_errorWithDomain:(NSString *)domain code:(NSInteger)code underlyingError:(NSError *)underlyingError descriptionFormat:(NSString *)descriptionFormat, ...;

// Returns the value of .userInfo[NSUnderlyingErrorKey]
@property (nonatomic, strong, readonly, nullable) NSError *br_underlyingError;

// Gives a cleaner version of -description. This can be useful when logging NSErrors to the console.
- (NSString *)br_diagnosticDescription;

@end

NS_ASSUME_NONNULL_END
