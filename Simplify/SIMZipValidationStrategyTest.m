/* Copyright (c) 2013, Asynchrony Solutions, Inc.
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *    * Neither the name of Asynchrony Solutions, Inc. nor the
 *      names of its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *  DISCLAIMED. IN NO EVENT SHALL ASYNCHRONY SOLUTIONS, INC. BE LIABLE FOR ANY
 *  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SIMAbstractTestCase.h"
#import "SIMZipValidationStrategy.h"

@interface SIMZipValidationStrategyTest : SIMAbstractTestCase {
	SIMZipValidationStrategy *testObject;
}
@end

@implementation SIMZipValidationStrategyTest

- (void)setUp {
	[super setUp];
	testObject = [[SIMZipValidationStrategy alloc] init];
}

- (void)tearDown {
	[super tearDown];
}

- (void)assertInput:(NSString *)input hasText:(NSString *)text andInputState:(SIMTextInputState)inputState {
	SIMTextFieldState *result = [testObject stateForInput:input];
	GHAssertEqualStrings(result.text, text, nil);
	GHAssertEquals(result.inputState, inputState, nil);
}

- (void)testStateForControl_OnlyAcceptsNumbers {
	[self assertInput:@"asb" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"B" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"1" hasText:@"1" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"12" hasText:@"12" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"123" hasText:@"123" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"1234" hasText:@"1234" andInputState:SIMTextInputStateNormal];
}

- (void)testStateForControl_ReturnsInputStateGood_OnZipWith5Numbers {
	[self assertInput:@"12345" hasText:@"12345" andInputState:SIMTextInputStateGood];
}

- (void)testStateForControl_ReturnsInputStateGood_OnZipWith9Numbers {
	[self assertInput:@"123456789" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12345-6789" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
}

- (void)testStateForControl_AddsDash_OnZipsBiggerThan5Numbers {
	[self assertInput:@"123456" hasText:@"12345-6" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"12345-" hasText:@"12345" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12345-67" hasText:@"12345-67" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"12345-678" hasText:@"12345-678" andInputState:SIMTextInputStateNormal];
}

- (void)testStateForControl_HasMaxOf9Digits {
	[self assertInput:@"12345-67891" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12345-6789-" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12345-6789x" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12x345-6789" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
}

@end
