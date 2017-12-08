//
//  DSHttpInstitutionsPutCmd.h
//  DreamStation
//
//  Created by xjb on 16/10/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePutCmd.h"

@interface DSHttpInstitutionsPutCmd : SNHttpBasePutCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_InstitutionsPut_user_id;
extern NSString *const kHttpParamKey_InstitutionsPut_institutionId;
extern NSString *const kHttpParamKey_InstitutionsPut_role_name;
extern NSString *const kHttpParamKey_InstitutionsPut_institutioners;
extern NSString *const kHttpParamKey_InstitutionsPut_login;
extern NSString *const kHttpParamKey_InstitutionsPut_id;
extern NSString *const kHttpParamKey_InstitutionsPut_name;
extern NSString *const kHttpParamKey_InstitutionsPut_title;
extern NSString *const kHttpParamKey_InstitutionsPut_cardUrl;
extern NSString *const kHttpParamKey_InstitutionsPut_mail;
extern NSString *const kHttpParamKey_InstitutionsPut_weichat;
extern NSString *const kHttpParamKey_InstitutionsPut_linkedin;
extern NSString *const kHttpParamKey_InstitutionsPut_investMin;
extern NSString *const kHttpParamKey_InstitutionsPut_investMax;
extern NSString *const kHttpParamKey_InstitutionsPut_company;
extern NSString *const kHttpParamKey_InstitutionsPut_logo;
extern NSString *const kHttpParamKey_InstitutionsPut_licence;
extern NSString *const kHttpParamKey_InstitutionsPut_phone;
extern NSString *const kHttpParamKey_InstitutionsPut_address;
extern NSString *const kHttpParamKey_InstitutionsPut_homePage;
extern NSString *const kHttpParamKey_InstitutionsPut_companyInvestMax;
extern NSString *const kHttpParamKey_InstitutionsPut_companyInvestMin;
extern NSString *const kHttpParamKey_InstitutionsPut_introduction;
extern NSString *const kHttpParamKey_InstitutionsPut_cases;
extern NSString *const kHttpParamKey_InstitutionsPut_wechat;
extern NSString *const kHttpParamKey_InstitutionsPut_job;
extern NSString *const kHttpParamKey_InstitutionsPut_mobilePhone;
extern NSString *const kHttpParamKey_InstitutionsPut_individualMail;
extern NSString *const kHttpParamKey_InstitutionsPut_bussinessCard;
extern NSString *const kHttpParamKey_InstitutionsPut_cats;
