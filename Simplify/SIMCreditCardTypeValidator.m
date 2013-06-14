#import "SIMCreditCardTypeValidator.h"
#import "NSString+Simplify.h"

@implementation SIMCreditCardTypeValidator

- (SIMCreditCardType)creditCardTypeForCreditCardNumber:(NSString *)creditCardNumber {
	if ([creditCardNumber hasAnyPrefix:@[@"34",@"37"]]) {
		return SIMCreditCardType_AmericanExpress;
	} else if ([creditCardNumber hasAnyPrefix:@[@"65",@"6011",@"644",@"645",@"646",@"647",@"648",@"649"]]) {
		return SIMCreditCardType_Discover;
	} else if ([creditCardNumber hasAnyPrefix:@[@"51",@"52",@"53",@"54",@"55"]]) {
		return SIMCreditCardType_MasterCard;
	} else if ([creditCardNumber hasPrefix:@"4"]) {
		return SIMCreditCardType_Visa;
	} else if ([creditCardNumber hasAnyPrefix:@[@"300",@"301",@"302",@"303",@"304",@"305",@"36", @"38", @"39"]]) {
		return SIMCreditCardType_DinersClub;
	} else if ([creditCardNumber hasAnyPrefix:@[ @"624", @"625", @"626"]]) {
		return SIMCreditCardType_ChinaUnionPay;
	} else {
		NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
		if (creditCardNumber.length >= 4 ) {
			NSNumber* firstFourDigits = [formatter numberFromString:[creditCardNumber substringToIndex:4]];
			if ( firstFourDigits.unsignedIntegerValue >= 3528 && firstFourDigits.unsignedIntegerValue <= 3589 ) {
				return SIMCreditCardType_JCB;
			}
		}
		if ( creditCardNumber.length >= 6 ) {
			NSNumber* firstSixDigits = [formatter numberFromString:[creditCardNumber substringToIndex:6]];
			if ( firstSixDigits.unsignedIntegerValue >= 622126 && firstSixDigits.unsignedIntegerValue <= 622925 ) {
				return SIMCreditCardType_ChinaUnionPay;
			}
		}
	}
	return SIMCreditCardType_Unknown;
}

@end
