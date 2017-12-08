//
//  DSHttpApplyParkChangeCmd.m
//  DreamStation
//
//  Created by xjb on 16/9/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpApplyParkChangeCmd.h"
#import "DSHttpApplyParkChangeResult.h"
static NSString *kActionUrl = @" /apply/park/";
@implementation DSHttpApplyParkChangeCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpApplyParkChangeCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpApplyParkChangeResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kActionUrl,self.requestInfo[kHttpParamKey_ApplyParkChange_userId]];
    return urlString;
}
@end
 NSString *const kHttpParamKey_ApplyParkChange_userId = @"userId";
 NSString *const kHttpParamKey_ApplyParkChange_applyLogin = @"applyLogin";
 NSString *const kHttpParamKey_ApplyParkChange_parkName = @"parkName";
 NSString *const kHttpParamKey_ApplyParkChange_parkLogo = @"parkLogo";
 NSString *const kHttpParamKey_ApplyParkChange_licence = @"licence";
 NSString *const kHttpParamKey_ApplyParkChange_officeRent = @"officeRent";
 NSString *const kHttpParamKey_ApplyParkChange_investService = @"investService";
 NSString *const kHttpParamKey_ApplyParkChange_address = @"address";
 NSString *const kHttpParamKey_ApplyParkChange_introducePic = @"introducePic";
 NSString *const kHttpParamKey_ApplyParkChange_introductionText = @"introductionText";
 NSString *const kHttpParamKey_ApplyParkChange_incubationCase = @"incubationCase";
 NSString *const kHttpParamKey_ApplyParkChange_joinCondition = @"joinCondition";
 NSString *const kHttpParamKey_ApplyParkChange_briefIntroduction = @"briefIntroduction";
 NSString *const kHttpParamKey_ApplyParkChange_vedioUrl = @"vedioUrl";
 NSString *const kHttpParamKey_ApplyParkChange_vedioTitle = @"vedioTitle";
 NSString *const kHttpParamKey_ApplyParkChange_vedioImg = @"vedioImg";
 NSString *const kHttpParamKey_ApplyParkChange_name = @"name";
 NSString *const kHttpParamKey_ApplyParkChange_job = @"job";
 NSString *const kHttpParamKey_ApplyParkChange_phone = @"phone";
 NSString *const kHttpParamKey_ApplyParkChange_email = @"email";
 NSString *const kHttpParamKey_ApplyParkChange_wechat = @"wechat";
 NSString *const kHttpParamKey_ApplyParkChange_linkdin = @"linkdin";
 NSString *const kHttpParamKey_ApplyParkChange_card = @"card";