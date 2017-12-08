//
//  DSHttpChangeParkPerInfoCmd.h
//  DreamStation
//
//  Created by xjb on 16/9/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePutCmd.h"

@interface DSHttpChangeParkPerInfoCmd : SNHttpBasePutCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ChangeParkPerInfo_user_id;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_id;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_parkName;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_parkLogo;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_licence;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_officeRent;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_investService;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_address;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_introducePic;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_introductionText;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_incubationCase;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_joinCondition;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_briefIntroduction;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_vedioUrl;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_vedioTitle;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_vedioImg;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_name;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_job;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_phone;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_wechat;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_email;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_linkdin;
extern NSString *const kHttpParamKey_ChangeParkPerInfo_card;
