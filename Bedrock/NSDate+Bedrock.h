//
//  NSDate+Bedrock.h
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSTimeInterval NSTimeIntervalWithMinutes(double minutes);
extern NSTimeInterval NSTimeIntervalWithHours(double hours);
extern NSTimeInterval NSTimeIntervalWithDays(double days);


@interface NSDate (Bedrock)


// "Until" in these methods is the opposite of "Since" in the NSDate API.

// Returns the time interval from <date> until <now>
+ (NSTimeInterval)br_timeIntervalSinceDate:(NSDate *)date;

// Returns the time interval from <now> until <date>
+ (NSTimeInterval)br_timeIntervalUntilDate:(NSDate *)date;

// Returns the time interval from <self> until <now>
- (NSTimeInterval)br_timeIntervalUntilNow;

// Returns the time interval from <self> until <date>
- (NSTimeInterval)br_timeIntervalUntilDate:(NSDate *)date;


- (BOOL)br_isEarlierThanDate:(NSDate *)date;
- (BOOL)br_isLaterThanDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
