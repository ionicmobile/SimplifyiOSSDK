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

- (id)initWithAddressView:(BOOL)showAddressView {
	if (self = [super init]) {
		SIMCreditCardNetwork *creditCardNetwork = [[SIMCreditCardNetwork alloc] init];
		SIMLuhnValidator *luhnValidator = [[SIMLuhnValidator alloc] init];
		SIMCurrentTimeProvider *timeProvider = [[SIMCurrentTimeProvider alloc] init];
		SIMCreditCardValidator *creditCardValidator = [[SIMCreditCardValidator alloc] initWithLuhnValidator:luhnValidator timeProvider:timeProvider];
		SIMCreditCardEntryModel *model = [[SIMCreditCardEntryModel alloc] initWithCreditCardNetwork:creditCardNetwork creditCardValidator:creditCardValidator];
		
		SIMAddressEntryView *addressEntryView = nil;
		if (showAddressView) {
			addressEntryView = [[SIMAddressEntryView alloc] init];
			SIMAddressEntryModel *addressEntryModel = [[SIMAddressEntryModel alloc] init];
			addressEntryView.stateTextField.options = addressEntryModel.stateOptions;
		}
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

- (void)control:(SIMCreditCardEntryControl)control setInput:(NSString *)input {
	SIMTextFieldState *textFieldState = [self.model stateForControl:control withInput:input];
	[self.internalView setTextFieldState:textFieldState forControl:control];
	[self updateCardTypeAndCreditCardButtonEnabled];
}

- (void)sendCreditCardButtonTapped {
	SIMCreditCardToken *creditCardToken = [self.model sendForCreditCardToken];
	[self.delegate receivedCreditCardToken:creditCardToken];
}

@end
