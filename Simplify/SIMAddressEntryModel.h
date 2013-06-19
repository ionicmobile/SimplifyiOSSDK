#import "SIMTextFieldState.h"
#import "SIMAddressEntryControl.h"
#import "SIMAddress.h"
#import "SIMGeneralValidationStrategy.h"

@interface SIMAddressEntryModel : NSObject

@property (nonatomic, readonly) NSDictionary *stateOptions;

- (id)initWithNameValidator:(id<SIMGeneralValidationStrategy>)nameValidator
      addressLine1Validator:(id<SIMGeneralValidationStrategy>)addressLine1Validator
	  addressLine2Validator:(id<SIMGeneralValidationStrategy>)addressLine2Validator
			  cityValidator:(id<SIMGeneralValidationStrategy>)cityValidator
			 stateValidator:(id<SIMGeneralValidationStrategy>)stateValidator
			   zipValidator:(id<SIMGeneralValidationStrategy>)zipValidator;

- (SIMTextFieldState *)stateForControl:(SIMAddressEntryControl)control withInput:(NSString *)input;

- (SIMAddress *)createAddressFromInput;

@end
