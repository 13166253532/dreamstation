//
//  DSHttpAddApplyProjectCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpAddApplyProjectCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_AddApplyProject_user_id;
extern NSString *const kHttpParamKey_AddApplyProject_role_name;

extern NSString *const kHttpParamKey_AddApplyProject_applyLogin;
extern NSString *const kHttpParamKey_AddApplyProject_project;

extern NSString *const kHttpParamKey_AddApplyProject_project_company;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_companyName;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_licenceUrl;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_address;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_myName;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_homePage;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_weichatPublic;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_businessCard;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_job;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_individualMail;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_weichat;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_linkedin;
extern NSString *const kHttpParamKey_AddApplyProject_project_company_isOnShow;

extern NSString *const kHttpParamKey_AddApplyProject_project_detail;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_amount;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_ratio;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_brief;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_videoUrl;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_needMoreService;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_needShow;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_needIncubator;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_extractionCode;
extern NSString *const kHttpParamKey_AddApplyProject_project_detail_downloadLink;
extern NSString *const kHttpParamKey_AddApplyProject_project_cats;
extern NSString *const kHttpParamKey_AddApplyProject_project_cats_catName;
extern NSString *const kHttpParamKey_AddApplyProject_project_cats_description;



