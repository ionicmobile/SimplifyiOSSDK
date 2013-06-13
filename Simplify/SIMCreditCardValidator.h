#import <Foundation/Foundation.h>
#import "SIMLuhnValidator.h"
#import "SIMCurrentTimeProvider.h"
#import "SIMCreditCardType.h"

@interface SIMCreditCardValidator : NSObject
@property (nonatomic, readonly) SIMCreditCardType cardType;
@property (nonatomic, strong, readonly) NSString* formattedCardNumber;
@property (nonatomic, strong, readonly) NSString* formattedCVCCode;
@property (nonatomic, strong, readonly) NSString* formattedExpirationDate;
@property (nonatomic, strong, readonly) NSString* expirationMonth;
@property (nonatomic, strong, readonly) NSString* expirationYear;

@property (nonatomic, readonly) BOOL isValidCardNumber;
@property (nonatomic, readonly) BOOL isMaximumCardNumberLength;

@property (nonatomic, readonly) BOOL isValidCVC;
@property (nonatomic, readonly) BOOL isMaximumCVCLength;

@property (nonatomic, readonly) BOOL isExpired;

-(id)initWithLuhnValidator:(SIMLuhnValidator*)luhnValidator timeProvider:(SIMCurrentTimeProvider*)timeProvider;
-(void)setCardNumberAsString:(NSString*)string;
-(void)setCVCCodeAsString:(NSString*)string;
-(void)setExpirationAsString:(NSString*)string;

@end
