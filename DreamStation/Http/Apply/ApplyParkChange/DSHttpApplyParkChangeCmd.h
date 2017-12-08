//
//  DSHttpApplyParkChangeCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/19.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePutCmd.h"

@interface DSHttpApplyParkChangeCmd : SNHttpBasePutCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ApplyParkChange_userId;
extern NSString *const kHttpParamKey_ApplyParkChange_applyLogin;
extern NSString *const kHttpParamKey_ApplyParkChange_parkName;
extern NSString *const kHttpParamKey_ApplyParkChange_parkLogo;
extern NSString *const kHttpParamKey_ApplyParkChange_licence;
extern NSString *const kHttpParamKey_ApplyParkChange_officeRent;
extern NSString *const kHttpParamKey_ApplyParkChange_investService;
extern NSString *const kHttpParamKey_ApplyParkChange_address;
extern NSString *const kHttpParamKey_ApplyParkChange_introducePic;
extern NSString *const kHttpParamKey_ApplyParkChange_introductionText;
extern NSString *const kHttpParamKey_ApplyParkChange_incubationCase;
extern NSString *const kHttpParamKey_ApplyParkChange_joinCondition;
extern NSString *const kHttpParamKey_ApplyParkChange_briefIntroduction;
extern NSString *const kHttpParamKey_ApplyParkChange_vedioUrl;
extern NSString *const kHttpParamKey_ApplyParkChange_vedioTitle;
extern NSString *const kHttpParamKey_ApplyParkChange_vedioImg;
extern NSString *const kHttpParamKey_ApplyParkChange_name;
extern NSString *const kHttpParamKey_ApplyParkChange_job;
extern NSString *const kHttpParamKey_ApplyParkChange_phone;
extern NSString *const kHttpParamKey_ApplyParkChange_email;
extern NSString *const kHttpParamKey_ApplyParkChange_wechat;
extern NSString *const kHttpParamKey_ApplyParkChange_linkdin;
extern NSString *const kHttpParamKey_ApplyParkChange_card;
