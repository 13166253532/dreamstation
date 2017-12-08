//
//  DSHttpInstitutionsPutCmd.m
//  DreamStation
//
//  Created by xjb on 16/10/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpInstitutionsPutCmd.h"
#import "DSHttpInstitutionsPutResult.h"

static NSString *kActionUrl = @"/accounts/institutions/";

@implementation DSHttpInstitutionsPutCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpInstitutionsPutCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpInstitutionsPutResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{

    NSString *url = [NSString stringWithFormat:@"%@%@/institutioners",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_InstitutionsPut_institutionId]];
    
    return url;
}
@end
 NSString *const kHttpParamKey_InstitutionsPut_user_id = @"user_id";
 NSString *const kHttpParamKey_InstitutionsPut_institutionId = @"institutionId";
 NSString *const kHttpParamKey_InstitutionsPut_role_name = @"role_name";
 NSString *const kHttpParamKey_InstitutionsPut_institutioners = @"institutioners";
 NSString *const kHttpParamKey_InstitutionsPut_login = @"login";
 NSString *const kHttpParamKey_InstitutionsPut_id = @"id";
 NSString *const kHttpParamKey_InstitutionsPut_name = @"name";
 NSString *const kHttpParamKey_InstitutionsPut_title = @"title";
 NSString *const kHttpParamKey_InstitutionsPut_cardUrl = @"cardUrl";
 NSString *const kHttpParamKey_InstitutionsPut_mail = @"mail";
 NSString *const kHttpParamKey_InstitutionsPut_weichat = @"weichat";
 NSString *const kHttpParamKey_InstitutionsPut_linkedin = @"linkedin";
 NSString *const kHttpParamKey_InstitutionsPut_investMin = @"investMin";
 NSString *const kHttpParamKey_InstitutionsPut_investMax = @"investMax";
 NSString *const kHttpParamKey_InstitutionsPut_company = @"company ";
 NSString *const kHttpParamKey_InstitutionsPut_logo = @"logo";
 NSString *const kHttpParamKey_InstitutionsPut_licence = @"licence";
 NSString *const kHttpParamKey_InstitutionsPut_phone = @"phone";
 NSString *const kHttpParamKey_InstitutionsPut_address = @"address";
 NSString *const kHttpParamKey_InstitutionsPut_homePage = @"homePage";
 NSString *const kHttpParamKey_InstitutionsPut_companyInvestMax = @"companyInvestMax";
 NSString *const kHttpParamKey_InstitutionsPut_companyInvestMin = @"companyInvestMin";
 NSString *const kHttpParamKey_InstitutionsPut_introduction = @"introduction";
 NSString *const kHttpParamKey_InstitutionsPut_cases = @"cases";
 NSString *const kHttpParamKey_InstitutionsPut_wechat = @"wechat";
 NSString *const kHttpParamKey_InstitutionsPut_job = @"job";
 NSString *const kHttpParamKey_InstitutionsPut_mobilePhone = @"mobilePhone";
 NSString *const kHttpParamKey_InstitutionsPut_individualMail = @"individualMail";
 NSString *const kHttpParamKey_InstitutionsPut_bussinessCard = @"bussinessCard";
 NSString *const kHttpParamKey_InstitutionsPut_cats = @"cats";
