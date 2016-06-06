//
//  NSObject+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSObject+Bedrock.h"
#import "BedrockMacros.h"
#import "NSArray+Bedrock.h"
#import "NSSet+Bedrock.h"

typedef NS_ENUM(NSInteger, DescriptionStyle) {
	DescriptionStyleObject,
	DescriptionStyleStruct,
};


@implementation NSObject (Bedrock)

- (NSString *)br_descriptionWithKeys:(NSArray *)keys
{
	return [self br_descriptionWithKeys:keys style:DescriptionStyleObject];
}

- (NSString *)br_structDescriptionWithKeys:(NSArray *)keys
{
	return [self br_descriptionWithKeys:keys style:DescriptionStyleStruct];
}

- (NSString *)br_descriptionWithKeys:(NSArray *)keys style:(DescriptionStyle)style
{
	NSMutableString *string = [NSMutableString new];
	switch (style) {
		case DescriptionStyleObject:
			[string appendFormat:@"<%@: %p { ", NSStringFromClass(self.class), self];
			break;
		case DescriptionStyleStruct:
			[string appendFormat:@"{"];
			break;
	}
	
	NSMutableArray *valueStrings = [NSMutableArray new];
	for (id propertyKey in keys) {
		NSString *label;
		id value;
		if ([propertyKey isKindOfClass:NSString.class]) {
			label = propertyKey;
			value = [self valueForKeyPath:propertyKey];
		} else if ([propertyKey isKindOfClass:NSDictionary.class]) {
			NSDictionary *propertyKeyDictionary = AsClass(propertyKey, NSDictionary);
			NSAssert(propertyKeyDictionary.count == 1, @"Dictionary Property Keys should have 1 key-value pair");
			label = propertyKeyDictionary.allKeys.firstObject;
			value = propertyKeyDictionary[label];
		}
		
		if (value != nil) {
			NSString *valueString;
			NSArray *valueAsArray = AsClass(value, NSArray);
			NSSet *valueAsSet = AsClass(value, NSSet);
			NSString *valueAsString = AsClass(value, NSString);
			if (valueAsArray != nil) {
				valueString = valueAsArray.br_singleLineDescription;
			} else if (valueAsSet != nil) {
				valueString = valueAsSet.br_singleLineDescription;
			} else if (valueAsString != nil) {
				valueString = [NSString stringWithFormat:@"\"%@\"", valueAsString];
			} else {
				valueString = [value description];
			}
			[valueStrings addObject:[NSString stringWithFormat:@"%@: %@", label, valueString]];
		}
	}
	[string appendString:[valueStrings componentsJoinedByString:@", "]];
	switch (style) {
		case DescriptionStyleObject:
			[string appendString:@" }>"];
			break;
		case DescriptionStyleStruct:
			[string appendString:@"}"];
			break;
	}
	return string;
}

@end
