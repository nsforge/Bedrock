//
//  NSObject+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Bedrock)

// Every object in <keys> must be either an NSString, or a single-entry NSDictionary<NSString *, id>.
//
// NSString entries will be treated as the key in a key-value pair. KVC will be used to find a value,
// and if the value is non-nil, it will be added to the resulting description string.
//
// NSDictionary<NSString *, id> entries will be treated as a key-value pair. The dictionary key will be
// treated as a key, and the the result of [anObject description] will be used for the object.
//
- (NSString *)br_descriptionWithKeys:(NSArray *)keys;


// This is used in the same way as -br_descriptionWithKeys:, but the object pointer isn't included
// in the string. This can be useful for value types or immutable objects, where the reference may not matter.
- (NSString *)br_structDescriptionWithKeys:(NSArray *)keys;

@end
