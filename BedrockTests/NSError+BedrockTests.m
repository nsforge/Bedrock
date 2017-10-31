//
//  NSError+BedrockTests.m
//  Bedrock
//
//  Created by Nick Forge on 6/06/2016.
//  Copyright © 2016 Nick Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Expecta;
@import Bedrock;

@interface NSError_BedrockTests : XCTestCase

@end

@implementation NSError_BedrockTests

- (void)test_errorWithDomainCodeDescription
{
	NSError *error = [NSError br_errorWithDomain:@"Domain" code:123 description:@"An error occurred"];
	expect(error).to.equal([[NSError alloc] initWithDomain:@"Domain" code:123 userInfo:@{NSLocalizedDescriptionKey: @"An error occurred"}]);
}

- (void)test_errorWithDomainCodeDescriptionFormat
{
	NSInteger problemCount = 5;
	NSError *error = [NSError br_errorWithDomain:@"Domain" code:123 descriptionFormat:@"%d things went wrong", problemCount];
	expect(error).to.equal([[NSError alloc] initWithDomain:@"Domain" code:123 userInfo:@{NSLocalizedDescriptionKey: @"5 things went wrong"}]);
}

- (void)test_errorWithDomainCodeUnderlyingErrorDescription
{
	NSError *underlyingError = [NSError br_errorWithDomain:@"UnderlyingDomain" code:123 description:@"a low-level thing went wrong"];
	NSError *superError = [NSError br_errorWithDomain:@"SuperDomain" code:456 underlyingError:underlyingError description:@"a high-level thing went wrong"];
	
	expect(superError).to.equal([[NSError alloc] initWithDomain:@"SuperDomain" code:456 userInfo:@{NSLocalizedDescriptionKey: @"a high-level thing went wrong", NSUnderlyingErrorKey: [NSError errorWithDomain:@"UnderlyingDomain" code:123 userInfo:@{NSLocalizedDescriptionKey: @"a low-level thing went wrong"}]}]);
}

- (void)test_errorWithDomainCodeUnderlyingErrorDescriptionFormat
{
	NSError *underlyingError = [NSError br_errorWithDomain:@"UnderlyingDomain" code:123 description:@"a low-level thing went wrong"];
	NSInteger errorCount = 1;
	NSError *superError = [NSError br_errorWithDomain:@"SuperDomain" code:456 underlyingError:underlyingError descriptionFormat:@"%lld things went wrong", errorCount];
	
	expect(superError).to.equal([[NSError alloc] initWithDomain:@"SuperDomain" code:456 userInfo:@{NSLocalizedDescriptionKey: @"1 things went wrong", NSUnderlyingErrorKey: [NSError errorWithDomain:@"UnderlyingDomain" code:123 userInfo:@{NSLocalizedDescriptionKey: @"a low-level thing went wrong"}]}]);
}

- (void)test_underlyingError
{
	NSError *error = [NSError errorWithDomain:@"Domain" code:123 userInfo:@{NSUnderlyingErrorKey: [NSError errorWithDomain:@"UnderlyingDomain" code:456 userInfo:nil]}];
	
	expect(error.br_underlyingError).to.equal([NSError errorWithDomain:@"UnderlyingDomain" code:456 userInfo:nil]);
}

- (void)test_diagnosticDescription
{
	NSError *error = [NSError br_errorWithDomain:@"Domain" code:123 description:@"An error occurred"];
	expect(error.br_diagnosticDescription).to.equal(@"Error Domain[123] 'An error occurred'");
	
	NSError *error2 = [NSError br_errorWithDomain:@"AnotherDomain" code:456 underlyingError:error description:@"Something lower-level went wrong"];
	expect(error2.br_diagnosticDescription).to.equal(@"Error AnotherDomain[456] 'Something lower-level went wrong' {NSUnderlyingError: (Error Domain[123] 'An error occurred')}");
}

@end
