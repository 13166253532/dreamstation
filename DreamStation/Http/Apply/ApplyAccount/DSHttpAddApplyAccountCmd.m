//
//  DSHttpAddApplyAccountCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpAddApplyAccountCmd.h"
#import "DSHttpAddApplyAccountResult.h"

static NSString *kActionUrl = @"/apply/account/";

@implementation DSHttpAddApplyAccountCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{

    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpAddApplyAccountCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{

    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpAddApplyAccountResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{

    NSString *stringUrl = [NSString stringWithFormat:@"%@%@/%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_AddApplyAccount_user_id],[self.requestInfo objectForKey:kHttpParamKey_AddApplyAccount_role_name]];
    return stringUrl;
}

@end

NSString *const kHttpParamKey_AddApplyAccount_user_id = @"user_id";
NSString *const kHttpParamKey_AddApplyAccount_role_name = @"role_name";

NSString *const kHttpParamKey_AddApplyAccount_applyLogin = @"applyLogin";
NSString *const kHttpParamKey_AddApplyAccount_institution = @"institution";


NSString *const kHttpParamKey_AddApplyAccount_institution_id = @"id";
NSString *const kHttpParamKey_AddApplyAccount_institution_name = @"name";
NSString *const kHttpParamKey_AddApplyAccount_institution_introduction = @"introduction";
NSString *const kHttpParamKey_AddApplyAccount_institution_cases = @"cases";
NSString *const kHttpParamKey_AddApplyAccount_institution_wechat = @"wechat";
NSString *const kHttpParamKey_AddApplyAccount_institution_Linkedin = @"linkedin";
NSString *const kHttpParamKey_AddApplyAccount_institution_avatar = @"avatar";
NSString *const kHttpParamKey_AddApplyAccount_institution_card_no = @"card_no";
NSString *const kHttpParamKey_AddApplyAccount_institution_idCardFrontUrl = @"idCardFrontUrl";
NSString *const kHttpParamKey_AddApplyAccount_institution_idCardBackUrl = @"idCardBackUrl";
NSString *const kHttpParamKey_AddApplyAccount_institution_individualPropertyUrl = @"individualPropertyUrl";
NSString *const kHttpParamKey_AddApplyAccount_institution_investMin = @"investMin";
NSString *const kHttpParamKey_AddApplyAccount_institution_investMax = @"investMax";
NSString *const kHttpParamKey_AddApplyAccount_institution_cats = @"cats";

NSString *const kHttpParamKey_AddApplyAccount_institution_company = @"company";
NSString *const kHttpParamKey_AddApplyAccount_institution_logo = @"logo";
NSString *const kHttpParamKey_AddApplyAccount_institution_licence = @"licence";
NSString *const kHttpParamKey_AddApplyAccount_institution_phone = @"phone";
NSString *const kHttpParamKey_AddApplyAccount_institution_mail = @"mail";
NSString *const kHttpParamKey_AddApplyAccount_institution_address = @"address";
NSString *const kHttpParamKey_AddApplyAccount_institution_homePage = @"homePage";
NSString *const kHttpParamKey_AddApplyAccount_institution_companyInvestMax = @"companyInvestMax";
NSString *const kHttpParamKey_AddApplyAccount_institution_companyInvestMin = @"companyInvestMin";
NSString *const kHttpParamKey_AddApplyAccount_institution_companyCats = @"companyCats";
NSString *const kHttpParamKey_AddApplyAccount_institution_job = @"job";
NSString *const kHttpParamKey_AddApplyAccount_institution_mobilePhone = @"mobilePhone";
NSString *const kHttpParamKey_AddApplyAccount_institution_individualMail = @"individualMail";
NSString *const kHttpParamKey_AddApplyAccount_institution_bussinessCard = @"bussinessCard";


NSString *const kHttpParamKey_AddApplyAccount_institution_cats_catName = @"catName";
NSString *const kHttpParamKey_AddApplyAccount_institution_cats_description = @"description";

