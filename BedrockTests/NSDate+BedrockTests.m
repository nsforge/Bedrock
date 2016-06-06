//
//  NSDate+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 6/06/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Expecta;
@import Bedrock;

@interface NSDate_BedrockTests : XCTestCase

@end

@implementation NSDate_BedrockTests

- (void)test_timeIntervalWithMinutes
{
	NSTimeInterval i = NSTimeIntervalWithMinutes(3);
	
	expect(i).to.equal(3 * 60);
}

- (void)test_timeIntervalWithHours
{
	NSTimeInterval i = NSTimeIntervalWithHours(0.5);
	
	expect(i).to.equal(60 * 30);
}

- (void)test_timeIntervalWithDays
{
	NSTimeInterval i = NSTimeIntervalWithDays(1.5);
	
	expect(i).to.equal(60 * 60 * 24 * 1.5);
}


// Note: tests that depend on NSDate's +new/+date/-init, which all depend on the system clock, are inherently
// fragile. The use of beCloseToWithin() is a bit of a hack, and it would be preferable to solve this
// in some other way.

- (void)test_timeIntervalSinceDate
{
	NSDate *tenSecondsAgo = [NSDate dateWithTimeIntervalSinceNow:-10];
	
	expect([NSDate br_timeIntervalSinceDate:tenSecondsAgo]).to.beCloseToWithin(10, 0.1);
}

- (void)test_timeIntervalUntilDateClassMethod
{
	NSDate *inTenSeconds = [NSDate dateWithTimeIntervalSinceNow:10];
	
	expect([NSDate br_timeIntervalUntilDate:inTenSeconds]).to.beCloseToWithin(10, 0.1);
}

- (void)test_timeIntervalUntilNow
{
	NSDate *tenSecondsAgo = [NSDate dateWithTimeIntervalSinceNow:-10];
	
	expect(tenSecondsAgo.br_timeIntervalUntilNow).to.beCloseToWithin(10, 0.1);
}

- (void)test_timeIntervalUntilDateInstanceMethod
{
	NSDate *fortyFiveSecondsAgo = [NSDate dateWithTimeIntervalSinceNow:-45];
	NSDate *inTenSeconds = [NSDate dateWithTimeIntervalSinceNow:10];
	
	expect([fortyFiveSecondsAgo br_timeIntervalUntilDate:inTenSeconds]).to.beCloseToWithin(55, 0.1);
}

- (void)test_isEarlierThanDate
{
	NSDate *now = [NSDate new];
	NSDate *oneSecondEarlier = [now dateByAddingTimeInterval:-1];
	
	expect([oneSecondEarlier br_isEarlierThanDate:now]).to.equal(YES);
	expect([now br_isEarlierThanDate:now]).to.equal(NO);
}

- (void)test_isLaterThanDate
{
	NSDate *now = [NSDate new];
	NSDate *oneSecondEarlier = [now dateByAddingTimeInterval:-1];
	
	expect([now br_isLaterThanDate:oneSecondEarlier]).to.equal(YES);
	expect([now br_isLaterThanDate:now]).to.equal(NO);
}

@end
