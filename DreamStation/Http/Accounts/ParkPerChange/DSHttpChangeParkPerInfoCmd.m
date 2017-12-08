//
//  DSHttpChangeParkPerInfoCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpChangeParkPerInfoCmd.h"
#import "DSHttpChangeParkPerInfoResult.h"

static NSString *kActionUrl = @"/accounts/park/user";

@implementation DSHttpChangeParkPerInfoCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpChangeParkPerInfoCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}
- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpChangeParkPerInfoResult alloc]init];
    }
    return self;
}
- (NSString *)getActionUrl{
    return kActionUrl;
}
@end
 NSString *const kHttpParamKey_ChangeParkPerInfo_user_id = @"user_id";
 NSString *const kHttpParamKey_ChangeParkPerInfo_id = @"id";
 NSString *const kHttpParamKey_ChangeParkPerInfo_parkName = @"parkName";
 NSString *const kHttpParamKey_ChangeParkPerInfo_parkLogo = @"parkLogo";
 NSString *const kHttpParamKey_ChangeParkPerInfo_licence = @"licence";
 NSString *const kHttpParamKey_ChangeParkPerInfo_officeRent = @"officeRent";
 NSString *const kHttpParamKey_ChangeParkPerInfo_investService = @"investService";
 NSString *const kHttpParamKey_ChangeParkPerInfo_address= @"address";
 NSString *const kHttpParamKey_ChangeParkPerInfo_introducePic = @"introducePic";
 NSString *const kHttpParamKey_ChangeParkPerInfo_introductionText = @"introductionText";
 NSString *const kHttpParamKey_ChangeParkPerInfo_incubationCase = @"incubationCase";
 NSString *const kHttpParamKey_ChangeParkPerInfo_joinCondition = @"joinCondition";
 NSString *const kHttpParamKey_ChangeParkPerInfo_briefIntroduction = @"briefIntroduction";
 NSString *const kHttpParamKey_ChangeParkPerInfo_vedioUrl = @"vedioUrl";
 NSString *const kHttpParamKey_ChangeParkPerInfo_vedioTitle = @"vedioTitle";
 NSString *const kHttpParamKey_ChangeParkPerInfo_vedioImg = @"vedioImg";
 NSString *const kHttpParamKey_ChangeParkPerInfo_name = @"name";
 NSString *const kHttpParamKey_ChangeParkPerInfo_job = @"job";
 NSString *const kHttpParamKey_ChangeParkPerInfo_phone = @"phone";
 NSString *const kHttpParamKey_ChangeParkPerInfo_wechat = @"wechat";
 NSString *const kHttpParamKey_ChangeParkPerInfo_email = @"email";
 NSString *const kHttpParamKey_ChangeParkPerInfo_linkdin = @"linkdin";
 NSString *const kHttpParamKey_ChangeParkPerInfo_card = @"card";
