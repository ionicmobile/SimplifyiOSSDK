#import "SIMTextField.h"
#import "SIMTextFieldModel.h"
#import "SIMModelDrivenTextFieldProtocol.h"

@interface SIMModelDrivenTextField : SIMTextField<SIMModelDrivenTextFieldProtocol>
@property (nonatomic) SIMTextFieldModel* model;
@end
