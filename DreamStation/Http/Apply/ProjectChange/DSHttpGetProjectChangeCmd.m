//
//  DSHttpGetProjectChangeCmd.m
//  DreamStation
//
//  Created by xjb on 2016/12/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpGetProjectChangeCmd.h"
#import "DSHttpGetProjectChangeResule.h"
static NSString *kActionUrl = @"/apply/project";

@implementation DSHttpGetProjectChangeCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpGetProjectChangeCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpGetProjectChangeResule alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end
 NSString *const kHttpParamKey_GetProjectChange_status = @"status";
 NSString *const kHttpParamKey_GetProjectChange_login = @"login";
 NSString *const kHttpParamKey_GetProjectChange_type = @"type";
 NSString *const kHttpParamKey_GetProjectChange_sortType = @"sortType";
