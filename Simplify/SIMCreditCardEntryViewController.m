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
		addressEntryView.stateTextField.model = addressEntryModel.stateModel;

		SIMCreditCardEntryView *view = [[SIMCreditCardEntryView alloc] initWithAddressEntryView:addressEntryView];

		self.model = model;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creditCardNumberDisplayChanged) name:SIMCreditCardEntryModelCreditCardNumberChanged object:model];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cvcNumberDisplayChanged) name:SIMCreditCardEntryModelCVCNumberChanged object:model];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expirationDateDisplayChanged) name:SIMCreditCardEntryModelExpirationDateChanged object:model];
		self.internalView = view;
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView {
	[super loadView];
	self.internalView.frame = self.view.bounds;
	[self.view addSubview:self.internalView];
	self.internalView.delegate = self;
}

#pragma mark - SIMCreditCardEntryViewDelegate Methods

-(void)creditCardNumberInput:(NSString*)input {
	[self.model creditCardNumberInput:input];
}

-(void)cvcNumberInput:(NSString*)input {
	[self.model cvcNumberInput:input];
}

-(void)expirationDateInput:(NSString*)input {
	[self.model expirationDateInput:input];
}

-(void)sendCreditCardButtonTapped {
	[self.model sendCreditCard];
}

#pragma mark - SIMCreditCardEntryModel notifications

-(void)creditCardNumberDisplayChanged {
	[self.internalView setCardNumberDisplayedText:self.model.creditCardNumberDisplay
	                               textInputState:self.model.creditCardNumberInputState];
	[self.internalView setCardType:self.model.creditCardType];
	[self.internalView setSendCreditCardButtonEnabled:self.model.canSendCreditCard];
}

-(void)cvcNumberDisplayChanged {
	[self.internalView setCVCNumberDisplayedText:self.model.cvcNumberDisplay
	                              textInputState:self.model.cvcNumberInputState];
	[self.internalView setSendCreditCardButtonEnabled:self.model.canSendCreditCard];
}

-(void)expirationDateDisplayChanged {
	[self.internalView setExpirationDateDisplayedText:self.model.expirationDateDisplay
	                                   textInputState:self.model.expirationDateInputState];
	[self.internalView setSendCreditCardButtonEnabled:self.model.canSendCreditCard];
}

@end
