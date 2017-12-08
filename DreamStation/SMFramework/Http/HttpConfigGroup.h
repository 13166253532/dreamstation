#import <Foundation/Foundation.h>

@class HttpConfig;

@interface HttpConfigGroup :NSObject
+(HttpConfigGroup *)sharedInstance;
-(HttpConfig *)getHttpConfig:(NSString *)key;
-(void)registerHttpConfig:(NSString *)key httpConfig:(HttpConfig *)httpConfig;
+(HttpConfig *)getCurrentConfig;
+(void)setCurrentConfig:(NSString *)key;
@end
