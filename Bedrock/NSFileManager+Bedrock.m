//
//  NSFileManager+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSFileManager+Bedrock.h"

@implementation NSFileManager (Bedrock)

- (BOOL)br_directoryExistsAtPath:(NSString *)path
{
	BOOL isDirectory;
	BOOL fileExists = [self fileExistsAtPath:path isDirectory:&isDirectory];
	return fileExists && isDirectory;
}

- (BOOL)br_createDirectoryWithIntermediateDirectoriesAtPath:(NSString *)path error:(NSError * __autoreleasing *)error
{
	return [self createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
}

@end
