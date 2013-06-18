
@interface NSString (Simplify)
-(BOOL)hasAnyPrefix:(NSArray*)prefixes;
-(NSString*)stringDividedByString:(NSString*)dividerString beforeIndicies:(NSArray*)indices;
-(NSString*)safeSubstringByTrimmingToLength:(NSUInteger)length;
-(NSString*)safeSubstringFromIndex:(NSUInteger)beginIndex toIndex:(NSUInteger)endIndex;
@end
