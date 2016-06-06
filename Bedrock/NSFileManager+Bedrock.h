//
//  NSFileManager+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Bedrock)

- (BOOL)br_directoryExistsAtPath:(NSString *)path;

// Convenience wrapper around -createDirectoryAtPath:withIntermediateDirectories:attributes:error:
- (BOOL)br_createDirectoryWithIntermediateDirectoriesAtPath:(NSString *)path error:(NSError * __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
