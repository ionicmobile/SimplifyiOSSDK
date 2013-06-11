@interface SIMCardToken : NSObject

@property (nonatomic, readonly) NSString *token;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *last4;
@property (nonatomic, readonly) NSString *addressLine1;
@property (nonatomic, readonly) NSString *addressLine2;
@property (nonatomic, readonly) NSString *addressCity;
@property (nonatomic, readonly) NSString *addressState;
@property (nonatomic, readonly) NSString *addressZip;
@property (nonatomic, readonly) NSString *addressCountry;
@property (nonatomic, readonly) NSNumber *expMonth;
@property (nonatomic, readonly) NSNumber *expYear;
@property (nonatomic, readonly) NSDate *dateCreated;

- (id)initWithToken:(NSString *)token
			   name:(NSString *)name
			   type:(NSString *)type
			  last4:(NSString *)last4
	   addressLine1:(NSString *)addressLine1
	   addressLine2:(NSString *)addressLine2
		addressCity:(NSString *)addressCity
	   addressState:(NSString *)addressState
		 addressZip:(NSString *)addressZip
	 addressCountry:(NSString *)addressCountry
		   expMonth:(NSNumber *)expMonth
			expYear:(NSNumber *)expYear
		dateCreated:(NSDate *)dateCreated;

+ (SIMCardToken *)cardTokenFromDictionary:(NSDictionary *)dictionary;

@end
