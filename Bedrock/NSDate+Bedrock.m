//
//  NSDate+Bedrock.m
//  Bedrock
//
//  Created by Nick Forge on 23/05/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import "NSDate+Bedrock.h"

NSTimeInterval NSTimeIntervalWithMinutes(double minutes)
{
	return minutes * 60.0;
}

NSTimeInterval NSTimeIntervalWithHours(double hours)
{
	return hours * 60.0 * 60.0;
}

NSTimeInterval NSTimeIntervalWithDays(double days)
{
	return days * 24.0 * 60.0 * 60.0;
}

@implementation NSDate (Bedrock)

// Returns the time interval from <date> until <now>
+ (NSTimeInterval)br_timeIntervalSinceDate:(NSDate *)date
{
	return -date.timeIntervalSinceNow;
}

// Returns the time interval from <now> until <date>
+ (NSTimeInterval)br_timeIntervalUntilDate:(NSDate *)date
{
	return date.timeIntervalSinceNow;
}

// Returns the time interval from <self> until <now>
- (NSTimeInterval)br_timeIntervalUntilNow
{
	return -self.timeIntervalSinceNow;
}

// Returns the time interval from <self> until <date>
- (NSTimeInterval)br_timeIntervalUntilDate:(NSDate *)date
{
	return [date timeIntervalSinceDate:self];
}

- (BOOL)br_isEarlierThanDate:(NSDate *)date
{
	return [self compare:date] == NSOrderedAscending;
}

- (BOOL)br_isLaterThanDate:(NSDate *)date
{
	return [self compare:date] == NSOrderedDescending;
}

@end
