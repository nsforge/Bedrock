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

@end

NS_ASSUME_NONNULL_END
