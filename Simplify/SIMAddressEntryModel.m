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

#import "SIMAddressEntryModel.h"
#import "SIMMutableAddress.h"
#import "SIMTextRequiredValidationStrategy.h"
#import "SIMStateValidationStrategy.h"
#import "SIMZipValidationStrategy.h"

@interface SIMAddressEntryModel ()

@property (nonatomic, readwrite) NSDictionary *stateOptions;
@property (nonatomic) SIMMutableAddress *address;
@property (nonatomic) id<SIMGeneralValidationStrategy> nameValidator;
@property (nonatomic) id<SIMGeneralValidationStrategy> addressLine1Validator;
@property (nonatomic) id<SIMGeneralValidationStrategy> addressLine2Validator;
@property (nonatomic) id<SIMGeneralValidationStrategy> cityValidator;
@property (nonatomic) id<SIMGeneralValidationStrategy> stateValidator;
@property (nonatomic) id<SIMGeneralValidationStrategy> zipValidator;

@end

@implementation SIMAddressEntryModel

- (id)init {
	return [self initWithNameValidator:[[SIMTextRequiredValidationStrategy alloc] init]
	             addressLine1Validator:[[SIMTextRequiredValidationStrategy alloc] init]
				 addressLine2Validator:[[SIMTextRequiredValidationStrategy alloc] init]
						 cityValidator:[[SIMTextRequiredValidationStrategy alloc] init]
						stateValidator:[[SIMStateValidationStrategy alloc] init]
						  zipValidator:[[SIMZipValidationStrategy alloc] init]];
}

- (id)initWithNameValidator:(id<SIMGeneralValidationStrategy>)nameValidator
      addressLine1Validator:(id<SIMGeneralValidationStrategy>)addressLine1Validator
	  addressLine2Validator:(id<SIMGeneralValidationStrategy>)addressLine2Validator
			  cityValidator:(id<SIMGeneralValidationStrategy>)cityValidator
			 stateValidator:(id<SIMGeneralValidationStrategy>)stateValidator
			   zipValidator:(id<SIMGeneralValidationStrategy>)zipValidator {
	if (self = [super init]) {
		self.nameValidator = nameValidator;
		self.addressLine1Validator = addressLine1Validator;
		self.addressLine2Validator = addressLine2Validator;
		self.cityValidator = cityValidator;
		self.stateValidator = stateValidator;
		self.zipValidator = zipValidator;
		self.stateOptions = @{
				@"Alabama":@"AL",
				@"Alaska":@"AK",
				@"Arizona":@"AZ",
				@"Arkansas":@"AR",
				@"California":@"CA",
				@"Colorado":@"CO",
				@"Connecticut":@"CT",
				@"Delaware":@"DE",
				@"Florida":@"FL",
				@"Georgia":@"GA",
				@"Hawaii":@"HI",
				@"Idaho":@"ID",
				@"Illinois":@"IL",
				@"Indiana":@"IN",
				@"Iowa":@"IA",
				@"Kansas":@"KS",
				@"Kentucky":@"KY",
				@"Louisiana":@"LA",
				@"Maine":@"ME",
				@"Maryland":@"MD",
				@"Massachusetts":@"MA",
				@"Michigan":@"MI",
				@"Minnesota":@"MN",
				@"Mississippi":@"MS",
				@"Missouri":@"MO",
				@"Montana":@"MT",
				@"Nebraska":@"NE",
				@"Nevada":@"NV",
				@"New Hampshire":@"NH",
				@"New Jersey":@"NJ",
				@"New Mexico":@"NM",
				@"New York":@"NY",
				@"North Carolina":@"NC",
				@"North Dakota":@"ND",
				@"Ohio":@"OH",
				@"Oklahoma":@"OK",
				@"Oregon":@"OR",
				@"Pennsylvania":@"PA",
				@"Rhode Island":@"RI",
				@"South Carolina":@"SC",
				@"South Dakota":@"SD",
				@"Tennessee":@"TN",
				@"Texas":@"TX",
				@"Utah":@"UT",
				@"Vermont":@"VT",
				@"Virginia":@"VA",
				@"Washington":@"WA",
				@"West Virginia":@"WV",
				@"Wisconsin":@"WI",
				@"Wyoming":@"WY"};

		self.address = [[SIMMutableAddress alloc] init];
	}
	return self;
}

- (SIMTextFieldState *)stateForControl:(SIMAddressEntryControl)control withInput:(NSString *)input {
	switch (control) {
	case SIMAddressEntryControlName: {
		SIMTextFieldState *state = [self.nameValidator stateForInput:input];
		self.address.name = state.text;
		return state;
	}case SIMAddressEntryControlLine1: {
		SIMTextFieldState *state = [self.addressLine1Validator stateForInput:input];
		self.address.addressLine1 = state.text;
		return state;
	}case SIMAddressEntryControlLine2: {
		SIMTextFieldState *state = [self.addressLine2Validator stateForInput:input];
		self.address.addressLine2 = state.text;
		return state;
	}case SIMAddressEntryControlCity: {
		SIMTextFieldState *state = [self.cityValidator stateForInput:input];
		self.address.city = state.text;
		return state;
	}case SIMAddressEntryControlState: {
		SIMTextFieldState *state = [self.stateValidator stateForInput:input];
		self.address.state = state.text;
		return state;
	}case SIMAddressEntryControlZip: {
		SIMTextFieldState *state = [self.zipValidator stateForInput:input];
		self.address.zip = state.text;
		return state;
	}
	}
	return nil;
}

- (SIMAddress *)createAddressFromInput {
	return self.address;
}

@end
