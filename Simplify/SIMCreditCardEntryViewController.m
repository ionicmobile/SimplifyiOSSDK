#import "SIMCreditCardEntryViewController.h"
#import "SIMAddressEntryModel.h"
#import "SIMCreditCardEntryModel.h"
#import "SIMCreditCardEntryView.h"
#import "SIMAddressEntryViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface SIMCreditCardEntryViewController() <SIMCreditCardEntryViewDelegate>
@property (nonatomic) SIMCreditCardEntryModel *model;
@property (nonatomic) SIMCreditCardEntryView *internalView;
@property (nonatomic) SIMAddressEntryViewController *addressViewController;
@end

@implementation SIMCreditCardEntryViewController

- (id)initWithPublicApiToken:(NSString *)publicApiToken addressView:(BOOL)showAddressView {
	if (self = [super init]) {
		SIMCreditCardNetwork *creditCardNetwork = [[SIMCreditCardNetwork alloc] initWithPublicApiToken:publicApiToken];
		SIMLuhnValidator *luhnValidator = [[SIMLuhnValidator alloc] init];
		SIMCurrentTimeProvider *timeProvider = [[SIMCurrentTimeProvider alloc] init];
		SIMCreditCardValidator *creditCardValidator = [[SIMCreditCardValidator alloc] initWithLuhnValidator:luhnValidator timeProvider:timeProvider];
		SIMCreditCardEntryModel *model = [[SIMCreditCardEntryModel alloc] initWithCreditCardNetwork:creditCardNetwork creditCardValidator:creditCardValidator];

		UIView *extraView = nil;
		if (showAddressView) {
			self.addressViewController = [[SIMAddressEntryViewController alloc] init];
			extraView = self.addressViewController.view;
		}

		SIMCreditCardEntryView *view = [[SIMCreditCardEntryView alloc] initWithExtraView:extraView];

		self.model = model;
		self.internalView = view;
	}
	return self;
}

- (void)loadView {
	[super loadView];
	self.view = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
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
	NSError *error = nil;
	SIMCreditCardToken *creditCardToken = [self.model sendForCreditCardTokenUsingAddress:self.addressViewController.address error:&error];
	[self.delegate receivedCreditCardToken:creditCardToken error:error];
}

@end
