@interface SIMAddress : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *addressLine1;
@property (nonatomic, readonly) NSString *addressLine2;
@property (nonatomic, readonly) NSString *city;
@property (nonatomic, readonly) NSString *state;
@property (nonatomic, readonly) NSString *zip;
@property (nonatomic, readonly) NSString *country;

- (id)initWithName:(NSString *)name
	  addressLine1:(NSString *)addressLine1
	  addressLine2:(NSString *)addressLine2
			  city:(NSString *)city
			 state:(NSString *)state
			   zip:(NSString *)zip;

@end
