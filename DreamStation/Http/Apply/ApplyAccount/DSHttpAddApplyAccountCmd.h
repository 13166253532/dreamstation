//
//  DSHttpAddApplyAccountCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpAddApplyAccountCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_AddApplyAccount_user_id;
extern NSString *const kHttpParamKey_AddApplyAccount_role_name;

extern NSString *const kHttpParamKey_AddApplyAccount_applyLogin;
extern NSString *const kHttpParamKey_AddApplyAccount_institution;

extern NSString *const kHttpParamKey_AddApplyAccount_institution_id;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_name;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_introduction;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_cases;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_wechat;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_Linkedin;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_avatar;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_card_no;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_idCardFrontUrl;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_idCardBackUrl;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_individualPropertyUrl;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_investMin;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_investMax;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_cats;

extern NSString *const kHttpParamKey_AddApplyAccount_institution_company;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_logo;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_licence;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_phone;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_mail;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_address;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_homePage;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_companyInvestMax;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_companyInvestMin;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_companyCats;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_job;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_mobilePhone;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_individualMail;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_bussinessCard;

extern NSString *const kHttpParamKey_AddApplyAccount_institution_cats_catName;
extern NSString *const kHttpParamKey_AddApplyAccount_institution_cats_description;

