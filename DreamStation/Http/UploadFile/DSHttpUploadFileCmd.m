//
//  DSHttpUploadFileCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpUploadFileCmd.h"
#import "DSHttpUploadFileResult.h"
///resource
static NSString *kActionUrl = @"/resource/upload";
@implementation DSHttpUploadFileCmd

+(HttpCommand *)httpCommandWithVersion:(NSString *)version
{
    if ([version isEqualToString:PHttpVersion_v1])
    {
        return [[DSHttpUploadFileCmd alloc] initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO,@"Invalid version");
    }
    return nil;
}
-(instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self=[super initWithAuthorizationState:state];
    if (nil != self){
        self.result = [[DSHttpUploadFileResult alloc] init];
    }
    
    return  self;
}

-(NSString *)getActionUrl{
    return kActionUrl;
}

@end
