#import "SIMCreditCardEntryViewController.h"
#import "SIMCreditCardEntryView.h"
#import "SIMCreditCardValidator.h"
#import "SIMCurrentTimeProvider.h"
#import "SIMLuhnValidator.h"
#import "SIMCreditCardNetwork.h"

@interface SIMCreditCardEntryViewController() <SIMCreditCardEntryViewDelegate>
@property (nonatomic, strong) SIMCreditCardNetwork *creditCardNetwork;
@property (nonatomic, strong) SIMCreditCardValidator* ccValidator;
@property (nonatomic, strong) SIMCreditCardEntryView* ccEntryView;
@end

@implementation SIMCreditCardEntryViewController

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)loadView {
    [super loadView];
	SIMCreditCardNetwork *creditCardNetwork = [[SIMCreditCardNetwork alloc] init];
    SIMLuhnValidator* luhnValidator = [[SIMLuhnValidator alloc] init];
    SIMCurrentTimeProvider* timeProvider = [[SIMCurrentTimeProvider alloc] init];
    SIMCreditCardValidator* ccValidator = [[SIMCreditCardValidator alloc] initWithLuhnValidator:luhnValidator timeProvider:timeProvider];
    SIMCreditCardEntryView* ccEntryView = [[SIMCreditCardEntryView alloc] initWithFrame:self.view.bounds];
	ccEntryView.delegate = self;

    self.creditCardNetwork = creditCardNetwork;
    self.ccValidator = ccValidator;
    self.ccEntryView = ccEntryView;

    [self.view addSubview:ccEntryView];
}

#pragma mark - SIMCreditCardEntryViewDelegate Methods

-(void)cardNumberChanged:(NSString*)cardNumber {
	[self.ccValidator setCardNumberAsString:cardNumber];
	[self.ccEntryView setCardNumber:self.ccValidator.formattedCardNumber isValid:self.ccValidator.isValidCardNumber isMaximumLength:self.ccValidator.isMaximumCardNumberLength];
	[self.ccEntryView setCardType:self.ccValidator.cardType];
}

-(void)cvcNumberChanged:(NSString*)cvcNumber {
	[self.ccValidator setCVCCodeAsString:cvcNumber];
	[self.ccEntryView setCVCCode:self.ccValidator.formattedCVCCode isValid:self.ccValidator.isValidCVC isMaximumLength:self.ccValidator.isMaximumCVCLength];
}

-(void)expirationDateChanged:(NSString*)expirationDate {
	[self.ccValidator setExpirationAsString:expirationDate];
	[self.ccEntryView setExpirationDate:self.ccValidator.formattedExpirationDate isValid:!self.ccValidator.isExpired];
}

-(void)doneButtonTapped {
	NSError *error = nil;
	NSString *unformattedCardNumber = [self.ccValidator.formattedCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
	SIMCardToken *cardToken = [self.creditCardNetwork createCardTokenWithExpirationMonth:self.ccValidator.expirationMonth
	                                                                      expirationYear:self.ccValidator.expirationYear
				                                                              cardNumber:unformattedCardNumber
							                                                         cvc:self.ccValidator.formattedCVCCode
							                                                       error:&error];
	NSLog(@"Card Token: %@", cardToken);
}

@end
