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
#import "SIMAddress.h"

@interface SIMAddressTest : SIMAbstractTestCase {
	SIMAddress *testObject;
}
@end

@implementation SIMAddressTest

- (void)setUp {
	[super setUp];
}

- (void)tearDown {
	[super tearDown];
}

- (void)testValues_AreSaved {
	testObject = [[SIMAddress alloc] initWithName:@"John Smith" addressLine1:@"100 Street" addressLine2:@"Suite 1" city:@"myCity" state:@"MO" zip:@"45454"];

	GHAssertEqualStrings(testObject.name, @"John Smith", nil);
	GHAssertEqualStrings(testObject.addressLine1, @"100 Street", nil);
	GHAssertEqualStrings(testObject.addressLine2, @"Suite 1", nil);
	GHAssertEqualStrings(testObject.city, @"myCity", nil);
	GHAssertEqualStrings(testObject.state, @"MO", nil);
	GHAssertEqualStrings(testObject.zip, @"45454", nil);
	GHAssertEqualStrings(testObject.country, @"US", nil);
}

@end
