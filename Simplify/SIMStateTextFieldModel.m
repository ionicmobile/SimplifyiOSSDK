#import "SIMStateTextFieldModel.h"
#import "SIMModelDrivenTextFieldProtocol.h"

@interface SIMStateTextFieldModel()
@property (nonatomic) NSArray *stateAbbreviations;
@property (nonatomic) NSArray *beginningOfStateAbbreviations;
@end

@implementation SIMStateTextFieldModel

- (id)init {
	if (self = [super init]) {
		self.beginningOfStateAbbreviations = @[@"", @"A", @"C", @"D", @"F", @"G", @"H", @"I", @"K", @"L", @"M", @"N", @"O", @"P", @"R", @"S", @"T", @"U", @"V", @"W"];
		self.stateAbbreviations = @[@"AL", @"AK", @"AZ", @"AR", @"CA", @"CO", @"CT", @"DE", @"FL", @"GA", @"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY",
							  @"LA", @"ME", @"MD", @"MA", @"MI", @"MN", @"MS", @"MO", @"MT", @"NE", @"NV", @"NH", @"NJ", @"NM", @"NY", @"NC", @"ND",
							  @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT", @"VA", @"WA", @"WV", @"WI", @"WY"];
	}
	return self;
}

- (void)textField:(id<SIMModelDrivenTextFieldProtocol>)textField input:(NSString *)input {
	NSString *uppercase = input.uppercaseString;
	if ([self.beginningOfStateAbbreviations containsObject:uppercase]) {
		[textField setText:input.uppercaseString];
		[textField setBackgroundColor:SIMTextColorNormal];
	} else if ([self.stateAbbreviations containsObject:uppercase]) {
		[textField setText:input.uppercaseString];
		[textField setBackgroundColor:SIMTextColorGood];
	}
}

@end
