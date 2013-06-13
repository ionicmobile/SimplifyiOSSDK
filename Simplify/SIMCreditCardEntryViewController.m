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
		self.internalView = view;
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
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
