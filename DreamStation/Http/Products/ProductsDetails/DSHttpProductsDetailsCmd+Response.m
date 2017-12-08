//
//  DSHttpProductsDetailsCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProductsDetailsCmd+Response.h"
#import "DSHttpProductsDetailsResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpProductsDetailsResultCategories;
@interface DSHttpProductsDetailsResultCategories : JSONModel
@property NSString<Optional> *name;
@property NSString<Optional> *description;
@end
@implementation DSHttpProductsDetailsResultCategories
@synthesize description;
@end

@interface DSHttpProductsDetailsResultContent : JSONModel
@property NSString<Optional> *linkedIn;
@property NSString<Optional> *depthRecommend;
@property NSString<Optional> *position;
@property NSString<Optional> *wxAccount;
@property NSString<Optional> *amount;
@property NSString<Optional> *needMoreService;
@property NSString<Optional> *market;
@property NSString<Optional> *hasShow;
@property NSString<Optional> *brief;
@property NSString<Optional> *homePage;
@property NSString<Optional> *videoUrl;
@property NSString<Optional> *highLight;
@property NSString<Optional> *id;
@property NSString<Optional> *wxPublicAccount;
@property NSString<Optional> *cardUrl;
@property NSString<Optional> *email;
@property NSString<Optional> *licenceUrl;
@property NSString<Optional> *needIncubator;
@property NSString<Optional> *companyName;
@property NSString<Optional> *businessMode;
@property NSString<Optional> *advantages;
@property NSString<Optional> *ratio;
@property NSString<Optional> *businessPlan;
@property NSString<Optional> *userName;
@property NSString<Optional> *myName;
@property NSString<Optional> *needShow;
@property NSString<Optional> *address;
@property NSString<Optional> *userId;
@property NSString<Optional> *interviewNum;
@property NSString<Optional> *productStatus;
@property NSString<Optional> *extractionCode;
@property NSString<Optional> *downloadLink;
@property NSMutableArray<DSHttpProductsDetailsResultCategories> *categories;
@end
@implementation DSHttpProductsDetailsResultContent
@end


@interface DSHttpProductsDetailsResult ()
@property DSHttpProductsDetailsResultContent *data;
@end


@implementation DSHttpProductsDetailsCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpProductsDetailsResult *result = (DSHttpProductsDetailsResult *)self.result;
    if (code >199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
       result.data = [[DSHttpProductsDetailsResultContent alloc]initWithDictionary:dic error:(NSError **)&error];
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

@implementation DSHttpProductsDetailsResult

- (NSMutableArray *)getAllContent{
    NSMutableArray *arr=[NSMutableArray array];
    DSProductsDetailsInfo *info = [[DSProductsDetailsInfo alloc]init];
    DSHttpProductsDetailsResultContent *webInfo=self.data;
    info.linkedIn = webInfo.linkedIn;
    //info.depthRecommend = webInfo.depthRecommend;
    info.position = webInfo.position;
    info.wxAccount = webInfo.wxAccount;
    //info.amount = webInfo.amount;
    info.amount = [NSString stringWithFormat:@"%@",[self getString:webInfo.amount]];
    info.needMoreService = webInfo.needMoreService;
    info.market = webInfo.market;
    
    info.brief = webInfo.brief;
    info.homePage = webInfo.homePage;
    info.videoUrl = webInfo.videoUrl;
    info.highLight = webInfo.highLight;
    info.id = webInfo.id;
    info.wxPublicAccount = webInfo.wxPublicAccount;
    info.cardUrl = webInfo.cardUrl;
    info.email = webInfo.email;
    info.licenceUrl = webInfo.licenceUrl;
    info.needIncubator = webInfo.needIncubator;
    info.companyName = webInfo.companyName;
    info.businessMode = webInfo.businessMode;
    info.advantages = webInfo.advantages;
    //info.ratio = webInfo.ratio;
    info.ratio = [NSString stringWithFormat:@"%@",[self getString:webInfo.ratio]];
    info.businessPlan = webInfo.businessPlan;
    info.userName = webInfo.userName;
    info.myName = webInfo.myName;
    info.needShow = webInfo.needShow;
    info.address = webInfo.address;
    info.userId = webInfo.userId;
    info.interviewNum = webInfo.interviewNum;
    info.productStatus = webInfo.productStatus;
    info.extractionCode = webInfo.extractionCode;
    info.downloadLink = webInfo.downloadLink;
    NSMutableArray *list = [NSMutableArray array];
    
    for (int i=0; i<webInfo.categories.count; i++) {
        DSHttpProductsDetailsResultCategories *categories = [[DSHttpProductsDetailsResultCategories alloc]init];
        categories = webInfo.categories[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"catName"] = categories.name;
        dic[@"description"] = categories.description;
        [info.categories addObject:dic];
        [info.categoriesArray addObject:dic];
        if ([categories.name isEqualToString:@"所属行业"]) {
            if (info.industry == nil) {
                info.industry = categories.description;
            }else{
                info.industry = [NSString stringWithFormat:@"%@ %@",info.industry,categories.description];
            }
            [info.industryList addObject:categories.description];
        }else if ([categories.name isEqualToString:@"投资偏好"]) {
            info.preferences = categories.description;
        }else if ([categories.name isEqualToString:@"融资阶段"]) {
            if (info.amountPhase == nil) {
                info.amountPhase = categories.description;
            }else{
                info.amountPhase = [NSString stringWithFormat:@"%@ %@",info.amountPhase,categories.description];
            }
        }else if ([categories.name isEqualToString:@"所在地区"]) {
            if (info.Inthearea == nil) {
                info.Inthearea = categories.description;
            }else{
                info.Inthearea = [NSString stringWithFormat:@"%@ %@",info.Inthearea,categories.description];
            }
        }else if ([categories.name isEqualToString:@"投资币种"]) {
            info.currency = categories.description;
        }else if ([categories.name isEqualToString:@"上过节目"]) {
            info.hasShow = categories.description;
        }else if ([categories.name isEqualToString:@"深度推荐"]) {
            info.depthRecommend = categories.description;
        }else if ([categories.name isEqualToString:@"有商业计划书"]){
            info.isBusinessPlan = categories.description;
        }
        
        [list addObject:categories];
    }
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:info.categories options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    info.cat = [self getStr:jsonString];
    info.categories = list;
    [arr addObject:info];
    return arr;
}
- (NSString *)getString:(NSString *)str{
    if (str != nil) {
        return str;
    }else{
        return @"";
    }
}


- (NSString *)getStr:(NSString *)str{
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str2;
}

@end
