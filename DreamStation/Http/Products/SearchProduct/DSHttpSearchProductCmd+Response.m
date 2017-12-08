//
//  DSHttpSearchProductCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/6.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSearchProductCmd+Response.h"
#import "DSHttpSearchProductResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpSearchProductCats;
@interface DSHttpSearchProductCats : JSONModel
@property NSString<Optional>*name;
@property NSString<Optional>*description;
@end
@implementation DSHttpSearchProductCats
@synthesize description;
@end

@protocol DSHttpSearchProductDetail;
@interface DSHttpSearchProductDetail : JSONModel
@property NSString<Optional>*id;
@property NSString<Optional>*companyName;
@property NSString<Optional>*licenceUrl;
@property NSString<Optional>*address;
@property NSString<Optional>*myName;
@property NSString<Optional>*homePage;
@property NSString<Optional>*wxPublicAccount;
@property NSString<Optional>*cardUrl;
@property NSString<Optional>*position;
@property NSString<Optional>*email;
@property NSString<Optional>*wxAccount;
@property NSString<Optional>*linkedIn;
@property NSString<Optional>*hasShow;
@property NSString<Optional>*amount;
@property NSString<Optional>*ratio;
@property NSString<Optional>*brief;
@property NSString<Optional>*videoUrl;
@property NSString<Optional>*needMoreService;
@property NSString<Optional>*needShow;
@property NSString<Optional>*needIncubator;
@property NSString<Optional>*highLight;
@property NSString<Optional>*market;
@property NSString<Optional>*businessMode;
@property NSString<Optional>*advantages;
@property NSString<Optional>*businessPlan;
@property NSString<Optional>*depthRecommend;
@property NSMutableArray<DSHttpSearchProductCats,Optional>*categories;
@end
@implementation DSHttpSearchProductDetail
@end


@interface DSHttpSearchProductContent : JSONModel
@property NSMutableArray<DSHttpSearchProductDetail>*content;
@end
@implementation DSHttpSearchProductContent
@end

@interface DSHttpSearchProductResult()
@property DSHttpSearchProductContent *data;
@end

@implementation DSHttpSearchProductCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpSearchProductResult *result = (DSHttpSearchProductResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpSearchProductContent alloc]initWithDictionary:dic error:(NSError **)&error];
        
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

@implementation DSHttpSearchProductResult

-(NSMutableArray *)getAllSearchContent{
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i<self.data.content.count; i++) {
        DSSearchProductInfo *info = [[DSSearchProductInfo alloc]init];
        DSHttpSearchProductDetail *webInfo = self.data.content[i];
        info.id = webInfo.id;
        info.companyName = webInfo.companyName;
        info.licenceUrl = webInfo.licenceUrl;
        info.address = webInfo.address;
        info.myName = webInfo.myName;
        info.homePage = webInfo.homePage;
        info.wxPublicAccount = webInfo.wxPublicAccount;
        info.cardUrl = webInfo.cardUrl;
        info.position = webInfo.position;
        info.email = webInfo.email;
        info.wxAccount = webInfo.wxAccount;
        info.linkedIn = webInfo.linkedIn;
        info.hasShow = webInfo.hasShow;
        info.amount = webInfo.amount;
        info.ratio = webInfo.ratio;
        info.brief = webInfo.brief;
        info.videoUrl = webInfo.videoUrl;
        info.needMoreService = webInfo.needMoreService;
        info.needShow = webInfo.needShow;
        info.needIncubator = webInfo.needIncubator;
        info.highLight = webInfo.highLight;
        info.market = webInfo.market;
        info.businessMode = webInfo.businessMode;
        info.advantages = webInfo.advantages;
        info.businessPlan = webInfo.businessPlan;
        info.depthRecommend = webInfo.depthRecommend;
        
        NSMutableArray *catList = [NSMutableArray array];
        for (int i = 0; i<webInfo.categories.count; i++) {
            DSSearchProductCatsInfo *info = [[DSSearchProductCatsInfo alloc]init];
            DSHttpSearchProductCats *webCatInfo = webInfo.categories[i];
            info.name = webCatInfo.name;
            info.descriptions = webCatInfo.description;
            [catList addObject:info];
        }
        info.categories = catList;
        
        [list addObject:info];
    }
    
   
    return list;
}

@end