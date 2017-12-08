//
//  DSHttpChangeMarkCmd.m
//  DreamStation
//
//  Created by xjb on 2016/12/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpChangeMarkCmd.h"
#import "DSHttpChangeMarkRecule.h"

static NSString *kActionUrl = @"/collections/mark/";
@implementation DSHttpChangeMarkCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpChangeMarkCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpChangeMarkRecule alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_ChangeMark_id]];
    return url;
}

@end
 NSString *const kHttpParamKey_ChangeMark_id = @"id";
 NSString *const kHttpParamKey_ChangeMark_mark = @"mark";
