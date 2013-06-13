#import "SIMCreditCardEntryViewController.h"

@interface SIMCreditCardEntryViewController() <SIMCreditCardEntryViewDelegate>
@property (nonatomic) SIMCreditCardEntryModel *model;
@property (nonatomic) SIMCreditCardEntryView *internalView;
@end

@implementation SIMCreditCardEntryViewController

- (id)init {
	SIMCreditCardNetwork *creditCardNetwork = [[SIMCreditCardNetwork alloc] init];
	SIMLuhnValidator *luhnValidator = [[SIMLuhnValidator alloc] init];
	SIMCurrentTimeProvider *timeProvider = [[SIMCurrentTimeProvider alloc] init];
	SIMCreditCardValidator *creditCardValidator = [[SIMCreditCardValidator alloc] initWithLuhnValidator:luhnValidator timeProvider:timeProvider];
	SIMCreditCardEntryModel *model = [[SIMCreditCardEntryModel alloc] initWithCreditCardNetwork:creditCardNetwork creditCardValidator:creditCardValidator];
	SIMCreditCardEntryView *view = [[SIMCreditCardEntryView alloc] init];
	return [self initWithModel:model view:view];
}

- (id)initWithModel:(SIMCreditCardEntryModel *)model view:(SIMCreditCardEntryView *)view {
	if (self = [super init]) {
		self.model = model;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creditCardNumberDisplayChanged) name:SIMCreditCardEntryModelCreditCardNumberChanged object:model];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cvcNumberDisplayChanged) name:SIMCreditCardEntryModelCVCNumberChanged object:model];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expirationDateDisplayChanged) name:SIMCreditCardEntryModelExpirationDateChanged object:model];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneEnabledChanged) name:SIMCreditCardEntryModelDoneEnabledChanged object:model];
		self.internalView = view;
	}
	return self;
}

-(void)loadView {
    [super loadView];
	self.internalView.frame = self.view.bounds;
	[self.view addSubview:self.internalView];
	self.internalView.delegate = self;
}

#pragma mark - SIMCreditCardEntryViewDelegate Methods

-(void)creditCardNumberInput:(NSString*)input {
	[self.model creditCardNumberInput:input];
//	[self.ccValidator setCardNumberAsString:input];
//	[self.ccEntryView setCardNumber:self.ccValidator.formattedCardNumber isValid:self.ccValidator.isValidCardNumber isMaximumLength:self.ccValidator.isMaximumCardNumberLength];
//	[self.ccEntryView setCardType:self.ccValidator.cardType];
}

-(void)cvcNumberInput:(NSString*)input {
	[self.model cvcNumberInput:input];
//	[self.ccValidator setCVCCodeAsString:input];
//	[self.ccEntryView setCVCCode:self.ccValidator.formattedCVCCode isValid:self.ccValidator.isValidCVC isMaximumLength:self.ccValidator.isMaximumCVCLength];
}

-(void)expirationDateInput:(NSString*)input {
	[self.model expirationDateInput:input];
//	[self.ccValidator setExpirationAsString:input];
//	[self.ccEntryView setExpirationDate:self.ccValidator.formattedExpirationDate isValid:!self.ccValidator.isExpired];
}

-(void)sendCreditCardButtonTapped {
	[self.model sendCreditCard];
}

#pragma mark - SIMCreditCardEntryModel notifications

-(void)creditCardNumberDisplayChanged {
	[self.internalView setExpirationDateDisplayedText:self.model.creditCardNumberDisplay
	                                   textInputState:self.model.creditCardNumberInputState];
}

-(void)cvcNumberDisplayChanged {
	[self.internalView setExpirationDateDisplayedText:self.model.cvcNumberDisplay
	                                   textInputState:self.model.cvcNumberInputState];
}

-(void)expirationDateDisplayChanged {
	[self.internalView setExpirationDateDisplayedText:self.model.expirationDateDisplay
	                                   textInputState:self.model.expirationDateInputState];
}

-(void)doneEnabledChanged {
	[self.internalView setSendCreditCardButtonEnabled:self.model.doneEnabled];
}

//	NSError *error = nil;
//	NSString *unformattedCardNumber = [self.ccValidator.formattedCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
//	SIMCardToken *cardToken = [self.creditCardNetwork createCardTokenWithExpirationMonth:self.ccValidator.expirationMonth
//	                                                                      expirationYear:self.ccValidator.expirationYear
//				                                                              cardNumber:unformattedCardNumber
//							                                                         cvc:self.ccValidator.formattedCVCCode
//							                                                       error:&error];
//	NSLog(@"Card Token: %@", cardToken);

@end
