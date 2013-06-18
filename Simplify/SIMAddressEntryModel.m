#import "SIMAddressEntryModel.h"
#import "SIMMutableAddress.h"

@interface SIMAddressEntryModel ()

@property (nonatomic, readwrite) NSDictionary *stateOptions;
@property (nonatomic) SIMMutableAddress *address;

@end

@implementation SIMAddressEntryModel

- (id)init {
	if (self = [super init]) {
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
		case SIMAddressEntryControlName:
			self.address.name = input;
			break;
		case SIMAddressEntryControlLine1:
			self.address.addressLine1 = input;
			break;
		case SIMAddressEntryControlLine2:
			self.address.addressLine2 = input;
			break;
		case SIMAddressEntryControlCity:
			self.address.city = input;
			break;
		case SIMAddressEntryControlState:
			self.address.state = input;
			break;
		case SIMAddressEntryControlZip:
			self.address.zip = input;
			break;
		default:
			break;
	}
	if ([input isEqualToString:@""]) {
		return [[SIMTextFieldState alloc] initWithText:input inputState:SIMTextInputStateNormal];
	} else {
		return [[SIMTextFieldState alloc] initWithText:input inputState:SIMTextInputStateGood];
	}
}

- (SIMAddress *)createAddressFromInput {
	return self.address;
}

@end
