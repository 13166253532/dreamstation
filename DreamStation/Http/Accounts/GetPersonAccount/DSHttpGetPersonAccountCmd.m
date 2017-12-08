//
//  DSHttpGetPersonAccountCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/30.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpGetPersonAccountCmd.h"
#import "DSHttpGetPersonAccountResult.h"

static NSString *kActionUrl = @"/accounts/persons/";

@implementation DSHttpGetPersonAccountCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpGetPersonAccountCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpGetPersonAccountResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{

    NSString *urlString = [NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_GetPersonAccount_person_id]];

    return urlString;
}

@end

NSString *const kHttpParamKey_GetPersonAccount_person_id = @"person_id";

