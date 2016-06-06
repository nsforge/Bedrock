//
//  BedrockMacros.h
//  Bedrock
//
//  Created by Nick Forge on 14/02/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//



//
// Type-Casting
//


//
// AsClass() returns <object> if it is a kind of <aClass>, or nil otherwise.
//
// Example
//
// NSURLResponse *response;
// NSHTTPURLResponse *httpResponse = AsClass(NSHTTPURLResponse, response);
//
#define AsClass(object, aClass) ([object isKindOfClass:[aClass class]] ? (aClass *) object : (aClass *) nil)



//
// AsClass() returns <object> if it conforms to <aProtocol>, or nil otherwise.
//
#define AsProtocol(object, aProtocol) ([object conformsToProtocol:@protocol(aProtocol)] ? (id<aProtocol>) object : (id<aProtocol>) nil)




//
// KVC Keys/Keypaths
//


// Example
//
// Key(NSString, length) => @"length"
//
#define Key(class, key)				(0 ? ((class *)nil).key, (NSString *)nil : @#key)


// Example
//
// ProtocolKey(NSDiscardableContent, isContentDiscarded) => @"isContentDiscarded"
//
#define ProtocolKey(protocol, key)	(0 ? ((id <protocol>)nil).key, (NSString *)nil : @#key)


// Example
//
// SelfKey(description) => @"description" (assuming that <self> in the current scope has a <description> method)
//
#define SelfKey(key)				(0 ? ((__typeof(self))nil).key, (NSString *)nil : @#key)


// Example
//
// NSString *myString = @"abc";
// InstanceKey(myString, length) => @"length"
//
#define InstanceKey(instance, key)	(0 ? ((__typeof(instance))nil).key, (NSString *)nil : @#key)



//
// Nil-safe Equality Checking
//

// Returns YES if either both x and y are nil, or if they equal the same object
// according to -isEqual:
//
#define ObjectsAreEqual(x, y) ((x == nil && y == nil) || (x != nil && [x isEqual:y]))
