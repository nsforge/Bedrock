# Bedrock [![Build Status](https://travis-ci.org/nsforge/Bedrock.svg?branch=master)](https://travis-ci.org/nsforge/Bedrock)

Bedrock is a library of Objective-C categories, functions and macros that make it easier to write cleaner, more concise, and more reliable code. It is currently only configured and tested on iOS, but could be easily extended to other Apple platforms.

## Principles

- Follow Apple's Objective-C naming conventions as closely as possible
- Use the most modern Objective-C language features, including generics and nullability annotations
- Use prefixes when categories to built-in system classes

For an introduction to Bedrock, see here: [http://unexpectederror.net/bedrock](http://unexpectederror.net/bedrock)

# Features

## Type-Safe Casting Macros

To safely cast an object to either a class or a protocol, you can use the `AsClass()` and `AsProtocol()` macros. These macros take two arguments – an object, and a class or a protocol (depending on the macro). If the object is a kind of the class, or conforms to the protocol, the macro returns the object, cast to the corresponding type. If not, the macro will return nil. Using these macros when performing potentially unsafe type casts gives you the safety of Swift's `as` operator in Objective-C.

```objc
id mysteryObject = @"Wubba Lubba Dub Dub!";

NSString *string = AsClass(mysteryObject, NSString);
// string = @"Wubba Lubba Dub Dub!";
NSNumber *number = AsClass(mysteryObject, NSNumber);
// number = nil	
id<NSCopying> copyable = AsProtocol(mysteryObject, NSCopying);
// copyable = @"Wubba Lubba Dub Dub!";
id<NSFastEnumeration> fastEnumerable = AsProtocol(mysteryObject, NSFastEnumeration);
// fastEnumerable = nil;
```

## Functional Collection Categories

Bedrock contains a large collection of categories on `NSArray`, `NSDictionary` and `NSSet` that allow you to write more expressive code without sacrificing the self-documenting nature of idiomatic Objective-C.

```objc
NSArray<NSString *> *names = @[@"Luke", @"Leia", @"Han", @"Darth"];
NSArray<NSString *> *fourLetterNames = [names br_allObjectsWhere:^BOOL(NSString *s) { return s.length == 4; }];
// => ["Luke", "Leia"]
NSInteger numberOfFiveLetterNames = [names br_numberOfObjectsWhere:^BOOL(NSString *s) { return s.length == 5; }];
// => 1

NSDictionary<NSString *,NSString *> *employees = @{
	@"Fry": @"Delivery Boy",
	@"Leela": @"Space Captain",
	@"Professor Farnsworth", @"Mad Scientist"
};
NSArray<NSString *> *employeeDescriptions = [employees br_arrayByMapping:^id(NSString *name, NSString *role) {
	return [NSString stringWithFormat:@"@% - @%", name, role];
}];
// => ["Fry - Delivery Boy", "Leela - Space Captain", "Professor Farnsworth - Mad Scientist"]

NSArray<NSString *> *flyingRoles = @[@"Space Captain", @"Space Pilot"];
NSDictionary<NSString *, NSString *> *employeesWhoCanFly = [employess br_allEntriesWhere:^BOOL(NSString *name, NSString *role) {
	return [flyingRoles containsObject:role];
}];
// => {"Leela": "Space Captain"}
```

## Keypath Macros
Bedrock contains the `Key()`, `ProtocolKey()`, `SelfKey()` and `InstanceKey()` macros to provide compile-time safe key paths for use with KVC APIs. They will give a compiler error if the keypath doesn't exist. An example of the `Key()` macro:

```objc
NSArray *strings = @[@"the", @"quick", @"brown", @"fox"];
NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:Key(NSString, length) ascending:ascending];
NSArray *stringsSortedByLength = [strings sortedArrayUsingDescriptors:@[descriptor]];
```

There's also a cleaner way to achieve the sorting described above by using another Bedrock category method:

```objc
NSArray *strings = @[@"the", @"quick", @"brown", @"fox"];
NSArray *stringsSortedByLength = [strings br_sortedArrayWithKey:Key(NSString, length) ascending:YES];
```

## -[NSObject description] Generation

Bedrock provides a very convenient way to generate `-description` and `-debugDescription` method implementations for your custom classes. Here's a quick example:

```objc
@interface Person : NSObject
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) NSInteger age; // in years
@end

@implementation Person
- (NSString *)description
{
	return [self br_descriptionWithKeys:@[SelfKey(name), SelfKey(age)]];
}
@end
```

Using a `Person` instance in a format string or when printing in the debugger will now result in a string of the form: `<Person: 0x019482 { name: "Fry", age: 37 }>`.

## Cryptographic Hashes on NSData

Apple provides a number of common cryptographic hashes through the CommonCrypto framework, but the API is in C, and binary data in Objective-C is typically represented using `NSData`. Bedrock provides categories for MD5, SHA1, SHA224, SHA256, SHA384 and SHA512 hashes.

## Hexadecimal String Conversions for NSData

Foundation provides methods for converting `NSData` to and from from raw memory, files and strings, but it doesn't provide a way to convert to and from hexadecimal string representations. These representations can be important if you need to show binary data in a UI, or represent binary data when serializing into a data format such as JSON.

```objc
NSData *data = [NSData br_dataWithHexString:@"0123456789abcdef"];
NSLog(@"%@", data); // logs: <01234567 89abcdef>

NSString *string = data.br_hexStringValue;
NSLog(@"%@", string); // logs: "0123456789abcdef"
```

## Extended NSDate API

The somewhat limited `NSDate` API can make for some awkward, unreadable code when it comes to both creating date objects, and performing comparison logic. The use of the "since" keyword often involves using negative multipliers and other hard to read techniques. Here's an example, with and without Bedrock category methods:

```objc
NSDate *anEventTime;

// Check if the event was less than 10 seconds ago
if (-anEventTime.timeIntervalSinceNow < 10) {
}

// Alternative approach
if (anEventTime.br_timeIntervalUntilNow < 10) {
}
```

If you have any questions, comments or suggestions, please get in touch! You'll find me on Twitter as [@nickforge](https://twitter.com/nickforge), and you can find my contact details at [nickforge.com](http://nickforge.com).
