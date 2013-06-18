#import "SIMCreditCardEntryViewController.h"
#import "SIMAddressEntryModel.h"
#import "SIMCreditCardEntryModel.h"
#import "SIMCreditCardEntryView.h"

@interface SIMCreditCardEntryViewController() <SIMCreditCardEntryViewDelegate>
@property (nonatomic) SIMCreditCardEntryModel *model;
@property (nonatomic) SIMCreditCardEntryView *internalView;
@property (nonatomic) SIMAddressEntryModel *addressModel;
@end

@implementation SIMCreditCardEntryViewController

- (id)init {
	if (self = [super init]) {
		SIMCreditCardNetwork *creditCardNetwork = [[SIMCreditCardNetwork alloc] init];
		SIMLuhnValidator *luhnValidator = [[SIMLuhnValidator alloc] init];
		SIMCurrentTimeProvider *timeProvider = [[SIMCurrentTimeProvider alloc] init];
		SIMCreditCardValidator *creditCardValidator = [[SIMCreditCardValidator alloc] initWithLuhnValidator:luhnValidator timeProvider:timeProvider];
		SIMCreditCardEntryModel *model = [[SIMCreditCardEntryModel alloc] initWithCreditCardNetwork:creditCardNetwork creditCardValidator:creditCardValidator];
		SIMAddressEntryView *addressEntryView = [[SIMAddressEntryView alloc] init];
		SIMAddressEntryModel *addressEntryModel = [[SIMAddressEntryModel alloc] init];
		addressEntryView.nameTextField.model = addressEntryModel.nameModel;

		SIMCreditCardEntryView *view = [[SIMCreditCardEntryView alloc] initWithAddressEntryView:addressEntryView];

		self.model = model;
		self.internalView = view;
	}
	return self;
}

- (void)loadView {
	[super loadView];
	self.internalView.frame = self.view.bounds;
	[self.view addSubview:self.internalView];
	self.internalView.delegate = self;
}

- (void)updateCardTypeAndCreditCardButtonEnabled {
	[self.internalView setCardType:self.model.creditCardType];
	[self.internalView setSendCreditCardButtonEnabled:self.model.canSendCreditCard];
}

#pragma mark - SIMCreditCardEntryViewDelegate Methods

- (void)creditCardNumberInput:(NSString*)input {
	SIMTextFieldState *resultState = [self.model stateForControl:SIMCreditCardEntryControlCreditCardNumber withInput:input];
	[self.internalView setCardNumberDisplayedText:resultState.text textInputState:resultState.inputState];
	[self updateCardTypeAndCreditCardButtonEnabled];
}

-(void)cvcNumberInput:(NSString*)input {
	SIMTextFieldState *resultState = [self.model stateForControl:SIMCreditCardEntryControlCVCNumber withInput:input];
	[self.internalView setCVCNumberDisplayedText:resultState.text textInputState:resultState.inputState];
	[self updateCardTypeAndCreditCardButtonEnabled];
}

-(void)expirationDateInput:(NSString*)input {
	SIMTextFieldState *resultState = [self.model stateForControl:SIMCreditCardEntryControlExpirationDate withInput:input];
	[self.internalView setExpirationDateDisplayedText:resultState.text textInputState:resultState.inputState];
	[self updateCardTypeAndCreditCardButtonEnabled];
}

- (void)sendCreditCardButtonTapped {
	[self.model sendCreditCard];
}

@end
