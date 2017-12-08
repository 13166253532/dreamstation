#import "HttpConfigGroup.h"

@interface HttpConfigGroup(priv)

@end
static NSMutableDictionary *mDic;
static NSString *mCurrentKey;

@implementation HttpConfigGroup
+(HttpConfigGroup *)sharedInstance{
    static HttpConfigGroup *_sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken,^{
       _sharedInstance = [[HttpConfigGroup alloc] init];
	});
    return _sharedInstance;
}

-(id) init{
	self  = [super init];
	if( nil != self){
	}
	return self;
}
#pragma make - Public
-(HttpConfig *)getHttpConfig:(NSString *)key
{
   return  [mDic objectForKey:(NSString *)key];
   // return [self objectForKey:key];
}
-(void)registerHttpConfig:(NSString *)key httpConfig:(HttpConfig *)httpConfig{
    if(nil == mDic){
      mDic = [[NSMutableDictionary alloc] init];
    }
    [mDic setObject:(id)httpConfig forKey:(id<NSCopying>)key];

    mCurrentKey = [[mDic allKeys] firstObject];
}
+(HttpConfig *)getCurrentConfig;
{
    return [mDic objectForKey:mCurrentKey];
}
+(void)setCurrentConfig:(NSString *)key{
    mCurrentKey = key;
}

@end


