//
//  DSHttpApplyAccountChangeCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/31.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpApplyAccountChangeCmd.h"
#import "DSHttpApplyAccountChangeResult.h"

static NSString *kActionUrl = @"/apply/account/";

@implementation DSHttpApplyAccountChangeCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpApplyAccountChangeCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpApplyAccountChangeResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@",kActionUrl,self.requestInfo[kHttpParamKey_ApplyAccountChange_user_id],self.requestInfo[kHttpParamKey_ApplyAccountChange_role_name]];
    return urlString;
}

@end

NSString *const kHttpParamKey_ApplyAccountChange_user_id = @"user_id";
NSString *const kHttpParamKey_ApplyAccountChange_role_name = @"role_name";
NSString *const kHttpParamKey_ApplyAccountChange_applyLogin = @"applyLogin";

NSString *const kHttpParamKey_ApplyAccountChange_id = @"id";
NSString *const kHttpParamKey_ApplyAccountChange_provider = @"provider";
NSString *const kHttpParamKey_ApplyAccountChange_institutionCreator = @"institutionCreator";
NSString *const kHttpParamKey_ApplyAccountChange_individual = @"individual";
NSString *const kHttpParamKey_ApplyAccountChange_login = @"login";
NSString *const kHttpParamKey_ApplyAccountChange_institutioner = @"institutioner";
NSString *const kHttpParamKey_ApplyAccountChange_authorized = @"authorized";
NSString *const kHttpParamKey_ApplyAccountChange_avatar = @"avatar";
NSString *const kHttpParamKey_ApplyAccountChange_createTime = @"createTime";
NSString *const kHttpParamKey_ApplyAccountChange_role = @"role";
NSString *const kHttpParamKey_ApplyAccountChange_park = @"park";
NSString *const kHttpParamKey_ApplyAccountChange_truthRole = @"truthRole";
NSString *const kHttpParamKey_ApplyAccountChange_name = @"name";
NSString *const kHttpParamKey_ApplyAccountChange_institution = @"institution";

//个人投资
NSString *const kHttpParamKey_ApplyAccountChange_individual_pv = @"pv";
NSString *const kHttpParamKey_ApplyAccountChange_individual_videoUrl = @"videoUrl";
NSString *const kHttpParamKey_ApplyAccountChange_individual_videoTitle = @"videoTitle";
NSString *const kHttpParamKey_ApplyAccountChange_individual_videoImage = @"videoImage";
NSString *const kHttpParamKey_ApplyAccountChange_individual_phone = @"phone";
NSString *const kHttpParamKey_ApplyAccountChange_individual_introduction = @"introduction";
NSString *const kHttpParamKey_ApplyAccountChange_individual_investMin = @"investMin";
NSString *const kHttpParamKey_ApplyAccountChange_individual_wechat = @"wechat";
NSString *const kHttpParamKey_ApplyAccountChange_individual_linkedIn = @"linkedin";
NSString *const kHttpParamKey_ApplyAccountChange_individual_cardNo = @"cardNo";
NSString *const kHttpParamKey_ApplyAccountChange_individual_cardNoBack = @"cardNoBack";
NSString *const kHttpParamKey_ApplyAccountChange_individual_personalAssetsCertificate = @"personalAssetsCertificate";
NSString *const kHttpParamKey_ApplyAccountChange_individual_investMax = @"investMax";
NSString *const kHttpParamKey_ApplyAccountChange_individual_cases = @"cases";
NSString *const kHttpParamKey_ApplyAccountChange_individual_popular = @"popular";
NSString *const kHttpParamKey_ApplyAccountChange_individual_createTime = @"createTime";
NSString *const kHttpParamKey_ApplyAccountChange_individual_cardNoFront = @"cardNoFront";
NSString *const kHttpParamKey_ApplyAccountChange_individual_cats = @"cats";

NSString *const kHttpParamKey_ApplyAccountChange_individual_cats_name = @"catName";
NSString *const kHttpParamKey_ApplyAccountChange_individual_cats_description = @"description";

//投资机构
NSString *const kHttpParamKey_ApplyAccountChange_institution_id = @"id";
NSString *const kHttpParamKey_ApplyAccountChange_institution_name = @"name";
NSString *const kHttpParamKey_ApplyAccountChange_institution_introduction = @"introduction";
NSString *const kHttpParamKey_ApplyAccountChange_institution_cases = @"cases";
NSString *const kHttpParamKey_ApplyAccountChange_institution_wechat = @"wechat";
NSString *const kHttpParamKey_ApplyAccountChange_institution_linkedin = @"linkedin";
NSString *const kHttpParamKey_ApplyAccountChange_institution_avatar = @"avatar";
NSString *const kHttpParamKey_ApplyAccountChange_institution_card_no = @"card_no";
NSString *const kHttpParamKey_ApplyAccountChange_institution_idCardFrontUrl = @"idCardFrontUrl";
NSString *const kHttpParamKey_ApplyAccountChange_institution_idCardBackUrl = @"idCardBackUrl";
NSString *const kHttpParamKey_ApplyAccountChange_institution_individualPropertyUrl = @"individualPropertyUrl";
NSString *const kHttpParamKey_ApplyAccountChange_institution_investMin = @"investMin";
NSString *const kHttpParamKey_ApplyAccountChange_institution_investMax = @"investMax";
NSString *const kHttpParamKey_ApplyAccountChange_institution_cats = @"cats";
NSString *const kHttpParamKey_ApplyAccountChange_institution_company = @"company";
NSString *const kHttpParamKey_ApplyAccountChange_institution_logo = @"logo";
NSString *const kHttpParamKey_ApplyAccountChange_institution_licence = @"licence";
NSString *const kHttpParamKey_ApplyAccountChange_institution_phone = @"phone";
NSString *const kHttpParamKey_ApplyAccountChange_institution_mail = @"mail";
NSString *const kHttpParamKey_ApplyAccountChange_institution_address = @"address";
NSString *const kHttpParamKey_ApplyAccountChange_institution_homePage = @"homePage";
NSString *const kHttpParamKey_ApplyAccountChange_institution_companyInvestMax = @"companyInvestMax";
NSString *const kHttpParamKey_ApplyAccountChange_institution_companyInvestMin = @"companyInvestMin";
NSString *const kHttpParamKey_ApplyAccountChange_institution_job = @"job";
NSString *const kHttpParamKey_ApplyAccountChange_institution_mobilePhone = @"mobilePhone";
NSString *const kHttpParamKey_ApplyAccountChange_institution_individualMail = @"individualMail";
NSString *const kHttpParamKey_ApplyAccountChange_institution_bussinessCard = @"bussinessCard";

NSString *const kHttpParamKey_ApplyAccountChange_institution_cats_catName = @"catName";
NSString *const kHttpParamKey_ApplyAccountChange_institution_cats_description = @"description";

