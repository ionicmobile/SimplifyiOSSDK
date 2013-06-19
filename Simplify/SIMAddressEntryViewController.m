#import "SIMAddressEntryViewController.h"
#import "SIMAddressEntryView.h"
#import "SIMAddressEntryModel.h"

@interface SIMAddressEntryViewController ()<SIMAddressEntryViewDelegate>

@property (nonatomic) SIMAddressEntryView *internalView;
@property (nonatomic) SIMAddressEntryModel *model;

@end

@implementation SIMAddressEntryViewController

- (id)init {
    if (self = [super init]) {
		self.model = [[SIMAddressEntryModel alloc] init];
    }
    return self;
}

- (void)loadView {
	[super loadView];
	self.internalView = [[SIMAddressEntryView alloc] initWithFrame:self.view.bounds];
	self.internalView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.internalView.delegate = self;
	self.view = self.internalView;

	[self.internalView setStateOptions:self.model.stateOptions];
}

- (SIMAddress *)address {
	return [self.model createAddressFromInput];
}

#pragma mark - SIMAddressEntryViewDelegate methods

- (void)control:(SIMAddressEntryControl)control setInput:(NSString *)input {
	SIMTextFieldState *state = [self.model stateForControl:control withInput:input];
	[self.internalView setTextFieldState:state forControl:control];
}


@end
