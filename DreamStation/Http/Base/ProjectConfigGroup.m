#import "ProjectConfigGroup.h"
#import "HTHttpConfig.h"

@interface ProjectConfigGroup(priv)
@end

@implementation ProjectConfigGroup
static NSDictionary *dic;

-(id) init{
	self  = [super init];
	if( nil != self){
    }
	return self;
}

#pragma make - Static funciton
+(void)initHttpConfig{
//    [[HttpConfigGroup sharedInstance] registerHttpConfig:[SNHttpConfig registerKey] httpConfig:[SNHttpConfig sharedInstance]];

    [[HttpConfigGroup sharedInstance] registerHttpConfig:[HTHttpConfig registerKey] httpConfig:[HTHttpConfig sharedInstance]];
}


@end


