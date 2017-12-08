//
//  DSHttpSearchInvestorCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSearchInvestorCmd+Response.h"
#import "DSHttpSearchInvestorResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpSearchInvestorCats;
@interface DSHttpSearchInvestorCats : JSONModel
@property NSString<Optional>*catName;
@property NSString<Optional>*description;
@end
@implementation DSHttpSearchInvestorCats
@synthesize description;
@end

@protocol DSHttpSearchInvestorContent;
@interface DSHttpSearchInvestorContent : JSONModel
@property NSString<Optional>*id;
@property NSString<Optional>*name;
@property NSString<Optional>*avatar;
@property NSString<Optional>*introduction;
@property NSString<Optional>*cases;
@property NSString<Optional>*investMin;
@property NSString<Optional>*investMax;
@property NSMutableArray<DSHttpSearchInvestorCats,Optional>*cats;
@property NSString<Optional>*pv;
@property NSString<Optional>*popular;
@property NSString<Optional>*videoUrl;
@property NSString<Optional>*videoTitle;
@property NSString<Optional>*videoImage;
@property NSString<Optional>*phone;
@property NSString<Optional>*wechat;
@property NSString<Optional>*linkedIn;
@property NSString<Optional>*createTime;
@property NSString<Optional>*cardNo;
@property NSString<Optional>*cardNoFront;
@property NSString<Optional>*cardNoBack;
@property NSString<Optional>*personalAssetsCertificate;
@property NSString<Optional>*account;
@property NSString<Optional>*mail;
@property NSString<Optional>*homePage;
@property NSString<Optional>*followNum;
@property NSString<Optional>*address;
@end
@implementation DSHttpSearchInvestorContent
@end

@protocol DSHttpSearchInvestorData;
@interface  DSHttpSearchInvestorData:JSONModel
@property NSMutableArray<DSHttpSearchInvestorContent,Optional>*content;
@end
@implementation DSHttpSearchInvestorData
@end

@interface DSHttpSearchInvestorResult()
@property DSHttpSearchInvestorData *data;
@end



@implementation DSHttpSearchInvestorCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpSearchInvestorResult *result = (DSHttpSearchInvestorResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpSearchInvestorData alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpSearchInvestorResult
- (NSMutableArray *)getSearchInvestorData{
    NSMutableArray *list = [NSMutableArray array];
    
    for (int i = 0; i<self.data.content.count; i++) {
        
        DSSearchInvestorInfo *info = [[DSSearchInvestorInfo alloc]init];
        DSHttpSearchInvestorContent *webInfo = self.data.content[i];
        info.id = webInfo.id;
        info.name = webInfo.name;
        info.avatar = webInfo.avatar;
        info.introduction = webInfo.introduction;
        info.cases = webInfo.cases;
        info.investMin = webInfo.investMin;
        info.investMax = webInfo.investMax;
        info.cats = [self getSearchInvestorCatsData:webInfo];
        info.pv = webInfo.pv;
        info.popular = webInfo.popular;
        info.videoUrl = webInfo.videoUrl;
        info.videoTitle = webInfo.videoTitle;
        info.videoImage = webInfo.videoImage;
        info.phone = webInfo.phone;
        info.wechat = webInfo.wechat;
        info.linkedIn = webInfo.linkedIn;
        info.createTime = webInfo.createTime;
        info.cardNo = webInfo.cardNo;
        info.cardNoFront = webInfo.cardNoFront;
        info.cardNoBack = webInfo.cardNoBack;
        info.personalAssetsCertificate = webInfo.personalAssetsCertificate;
        info.account = webInfo.account;
        info.mail = webInfo.mail;
        info.homePage = webInfo.homePage;
        info.followNum = webInfo.followNum;
        info.address = webInfo.address;
        [list addObject:info];
    }

    return list;
}

- (NSMutableArray *)getSearchInvestorCatsData:(DSHttpSearchInvestorContent *)contentInfo{
    NSMutableArray *list = [NSMutableArray array];
    for (int j = 0; j<contentInfo.cats.count; j++) {
        DSSearchInvestorCats *info = [[DSSearchInvestorCats alloc]init];
        DSHttpSearchInvestorCats *catInfo = contentInfo.cats[j];
        info.catName = catInfo.catName;
        info.descriptions = catInfo.description;
        [list addObject:info];
    }
    return list;
}

@end
