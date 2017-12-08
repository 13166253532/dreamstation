//
//  DSHttpGetProjectChangeCmd+Response.m
//  DreamStation
//
//  Created by xjb on 2016/12/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpGetProjectChangeCmd+Response.h"
#import "DSHttpGetProjectChangeResule.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"


@protocol DSHttpGetProjectChangeCompany;
@interface DSHttpGetProjectChangeCompany : JSONModel
@property NSString<Optional> *companyName;
@property NSString<Optional> *licenceUrl;
@property NSString<Optional> *address;
@property NSString<Optional> *myName;
@property NSString<Optional> *homePage;
@property NSString<Optional> *weichatPublic;
@property NSString<Optional> *businessCard;
@property NSString<Optional> *job;
@property NSString<Optional> *individualMail;
@property NSString<Optional> *weichat;
@property NSString<Optional> *linkedin;
@property NSString<Optional> *onShow;
@end
@implementation DSHttpGetProjectChangeCompany
@synthesize description;
@end

@protocol DSHttpGetProjectChangeDetail;
@interface DSHttpGetProjectChangeDetail : JSONModel
@property NSString<Optional> *amountMin;
@property NSString<Optional> *amountMax;
@property NSString<Optional> *login;
@property NSString<Optional> *highLight;
@property NSString<Optional> *market;
@property NSString<Optional> *businessMode;
@property NSString<Optional> *advantages;
@property NSString<Optional> *businessPlan;
@property NSString<Optional> *depthRecommend;
@property NSString<Optional> *amount;
@property NSString<Optional> *ratio;
@property NSString<Optional> *brief;
@property NSString<Optional> *videoUrl;
@property NSString<Optional> *needMoreService;
@property NSString<Optional> *needShow;
@property NSString<Optional> *needIncubator;
@end
@implementation DSHttpGetProjectChangeDetail
@synthesize description;
@end

@protocol DSHttpGetProjectChangeCats;
@interface DSHttpGetProjectChangeCats : JSONModel
@property NSString<Optional> *description;
@property NSString<Optional> *catName;
@end
@implementation DSHttpGetProjectChangeCats
@synthesize description;
@end

@protocol DSHttpPerProductsResultMessage;
@interface DSHttpPerProductsResultMessage : JSONModel
@property NSString<Optional> *id;
@property DSHttpGetProjectChangeCompany *company;
@property DSHttpGetProjectChangeDetail *detail;
@property NSString<Optional> *projectId;
@property NSString<Optional> *type;
@property NSMutableArray<DSHttpGetProjectChangeCats> *cats;
@end
@implementation DSHttpPerProductsResultMessage
@synthesize description;
@end


@protocol DSHttpGetProjectChangeContentList;
@interface DSHttpGetProjectChangeContentList : JSONModel
@property NSString<Optional> *status;
@property NSString<Optional> *userId;
@property NSString<Optional> *reason;
@property NSString<Optional> *id;
@property NSString<Optional> *role;
@property NSString<Optional> *applyTime;
@property NSString<Optional> *description;
@property NSString<Optional> *applyLogin;
@property NSString<Optional> *message;
@property NSString<Optional> *resultTime;
@property NSString<Optional> *type;
@end
@implementation DSHttpGetProjectChangeContentList
@synthesize description;
@end


@interface DSHttpGetProjectChangeResuleContent : JSONModel
@property NSMutableArray<DSHttpGetProjectChangeContentList> *content;
@end
@implementation DSHttpGetProjectChangeResuleContent
@end


@interface DSHttpGetProjectChangeResule ()
@property DSHttpGetProjectChangeResuleContent *data;
@end


@implementation DSHttpGetProjectChangeCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpGetProjectChangeResule *result = (DSHttpGetProjectChangeResule *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpGetProjectChangeResuleContent alloc]initWithDictionary:dic error:(NSError **)&error];
        
        if (error) {
            [self onRequestFailed:error];
            return;
        }
    }else{
        NSString *memo = [dic objectForKey:@"error_description"];
        [self.result setResultState:kRequestResultFail];
        [self.result setErrMsg:memo];
        NSLog(@"code :%ld errormsg:%@",(long)code,memo);
    }
}
- (void)onRequestFailed:(NSError *)error{
    NSLog(@"Error:%@",error);
    [self.result setErrMsg:[error localizedDescription]];
    [self.result setResultState:kRequestResultFail];
}

@end


@implementation DSHttpGetProjectChangeResule
- (NSMutableArray *)getProjectData{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<self.data.content.count; i++) {
        DSGetProjectChangeInfo *info = [[DSGetProjectChangeInfo alloc]init];
        DSHttpGetProjectChangeContentList *httpInfo = self.data.content[i];
        info.status = httpInfo.status;
        info.userId = httpInfo.userId;
        info.reason = httpInfo.reason;
        info.id = httpInfo.id;
        info.role = httpInfo.role;
        info.applyTime = httpInfo.applyTime;
        info.resultTime = httpInfo.resultTime;
        info.type = httpInfo.type;
        NSData *data = [httpInfo.message dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        DSHttpPerProductsResultMessage *messagr = [[DSHttpPerProductsResultMessage alloc]initWithDictionary:dic error:nil];
        info.message.id = messagr.id;
        info.message.projectId = messagr.projectId;
        info.message.type = messagr.type;
        info.message.company.companyName = messagr.company.companyName;
        info.message.company.licenceUrl = messagr.company.licenceUrl;
        info.message.company.address = messagr.company.address;
        info.message.company.myName = messagr.company.myName;
        info.message.company.homePage = messagr.company.homePage;
        info.message.company.weichatPublic = messagr.company.weichatPublic;
        info.message.company.businessCard = messagr.company.businessCard;
        info.message.company.individualMail = messagr.company.individualMail;
        info.message.company.weichat = messagr.company.weichat;
        info.message.company.linkedin = messagr.company.linkedin;
        info.message.company.onShow = messagr.company.onShow;
        info.message.detail.amountMin = messagr.detail.amountMin;
        info.message.detail.amountMax = messagr.detail.amountMax;
        info.message.detail.login = messagr.detail.login;
        info.message.detail.highLight = messagr.detail.highLight;
        info.message.detail.market = messagr.detail.market;
        info.message.detail.businessMode = messagr.detail.businessMode;
        info.message.detail.advantages = messagr.detail.advantages;
        info.message.detail.businessPlan = messagr.detail.businessPlan;
        info.message.detail.depthRecommend = messagr.detail.depthRecommend;
        info.message.detail.amount = messagr.detail.amount;
        info.message.detail.ratio = messagr.detail.ratio;
        info.message.detail.brief = messagr.detail.brief;
        info.message.detail.videoUrl = messagr.detail.videoUrl;
        info.message.detail.needMoreService = messagr.detail.needMoreService;
        info.message.detail.needShow = messagr.detail.needShow;
        info.message.detail.needIncubator = messagr.detail.needIncubator;
        for (int j = 0; j<messagr.cats.count; j++) {
            DSGetProjectChangeInfoCats *catsList = [[DSGetProjectChangeInfoCats alloc]init];
            DSHttpGetProjectChangeCats *catsHttp = messagr.cats[j];
            catsList.catName = catsHttp.catName;
            catsList.descriptions = catsHttp.description;
            [info.message.cats addObject:catsList];
        }
        [arr addObject:info];
    }
    return arr;
}








@end
