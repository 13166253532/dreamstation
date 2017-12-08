//
//  DSHttpApplyProjectChangeCmd.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpApplyProjectChangeCmd.h"
#import "DSHttpApplyProjectChangeResult.h"

static NSString *kActionUrl = @"/apply/project/";

@implementation DSHttpApplyProjectChangeCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpApplyProjectChangeCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpApplyProjectChangeResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{

    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@/%@",kActionUrl,self.requestInfo[kHttpParamKey_ApplyProjectChange_user_id],self.requestInfo[kHttpParamKey_ApplyProjectChange_role_name],self.requestInfo[kHttpParamKey_ApplyProjectChange_projectId]];
    return urlString;
}
@end


NSString *const kHttpParamKey_ApplyProjectChange_projectId = @"projectId";
NSString *const kHttpParamKey_ApplyProjectChange_user_id = @"user_id";
NSString *const kHttpParamKey_ApplyProjectChange_role_name = @"role_name";

NSString *const kHttpParamKey_ApplyProjectChange_applyLogin = @"applyLogin";
NSString *const kHttpParamKey_ApplyProjectChange_project = @"project";

NSString *const kHttpParamKey_ApplyProjectChange_project_company = @"company";
NSString *const kHttpParamKey_ApplyProjectChange_project_detail = @"detail";
NSString *const kHttpParamKey_ApplyProjectChange_project_cats = @"cats";
 NSString *const kHttpParamKey_ApplyProjectChange_project_type = @"type";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_companyName = @"companyName";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_licenceUrl = @"licenceUrl";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_address = @"address";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_myName = @"myName";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_homePage = @"homePage";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_weichatPublic = @"weichatPublic";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_businessCard = @"businessCard";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_job = @"job";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_individualMail = @"individualMail";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_weichat = @"weichat";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_linkedin = @"linkedin";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_isOnShow = @"isOnShow";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_hasShow = @"hasShow";

NSString *const kHttpParamKey_ApplyProjectChange_project_detail_amount = @"amount";
NSString *const kHttpParamKey_ApplyProjectChange_project_detail_ratio = @"ratio";
NSString *const kHttpParamKey_ApplyProjectChange_project_detail_brief = @"brief";
NSString *const kHttpParamKey_ApplyProjectChange_project_detail_videoUrl = @"videoUrl";
NSString *const kHttpParamKey_ApplyProjectChange_project_detail_needMoreService = @"needMoreService";
NSString *const kHttpParamKey_ApplyProjectChange_project_detail_needShow = @"needShow";
NSString *const kHttpParamKey_ApplyProjectChange_project_detail_needIncubator = @"needIncubator";
NSString *const kHttpParamKey_ApplyProjectChange_project_detail_depthRecommend = @"depthRecommend";
 NSString *const kHttpParamKey_ApplyProjectChange_project_detail_extractionCode = @"extractionCode";
 NSString *const kHttpParamKey_ApplyProjectChange_project_detail_downloadLink = @"downloadLink";
NSString *const kHttpParamKey_ApplyProjectChange_project_cats_catName = @"catName";
NSString *const kHttpParamKey_ApplyProjectChange_project_cats_description = @"description";
 NSString *const kHttpParamKey_ApplyProjectChange_project_company_highLight = @"highLight";
 NSString *const kHttpParamKey_ApplyProjectChange_project_company_businessMode = @"businessMode";
 NSString *const kHttpParamKey_ApplyProjectChange_project_company_market = @"market";
 NSString *const kHttpParamKey_ApplyProjectChange_project_company_advantages = @"advantages";
NSString *const kHttpParamKey_ApplyProjectChange_project_company_businessPlan = @"businessPlan";
