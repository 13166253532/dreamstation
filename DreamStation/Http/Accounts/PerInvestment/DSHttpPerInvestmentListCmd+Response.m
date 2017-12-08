//
//  DSHttpPerInvestmentListCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPerInvestmentListCmd+Response.h"
#import "DSHttpPerInvestmentListResule.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"


@protocol DSHttpPerInvestmentListCats;
@interface DSHttpPerInvestmentListCats : JSONModel
@property NSString<Optional> *catName;
@property NSString<Optional> *description;
@end
@implementation DSHttpPerInvestmentListCats
@synthesize description;
@end


@protocol DSHttpPerInvestmentListDetail;
@interface DSHttpPerInvestmentListDetail : JSONModel
@property NSString<Optional> *linedIn;
@property NSString<Optional> *cardNoBack;
@property NSString<Optional> *wechat;
@property NSString<Optional> *pv;
@property NSString<Optional> *personalAssetsCertificate;
@property NSString<Optional> *videoUrl;
@property NSString<Optional> *popular;
@property NSString<Optional> *name;
@property NSString<Optional> *videoImage;
@property NSString<Optional> *videoPrintScreen;
@property NSString<Optional> *id;
@property NSString<Optional> *cardNoFront;
@property NSString<Optional> *phone;
@property NSString<Optional> *videoTitle;
@property NSString<Optional> *avatar;
@property NSString<Optional> *introduction;
@property NSString<Optional> *createTime;
@property NSString<Optional> *cardNo;
@property NSString<Optional> *cases;
@property NSString<Optional> *account;
@property NSString<Optional> *investMin;
@property NSString<Optional> *investMax;
@property NSString<Optional> *followCount;

@property NSMutableArray<DSHttpPerInvestmentListCats> *cats;
@end
@implementation DSHttpPerInvestmentListDetail
@synthesize description;
@end


@interface DSHttpPerInvestmentListContent : JSONModel
@property NSMutableArray<DSHttpPerInvestmentListDetail> *content;
@end
@implementation DSHttpPerInvestmentListContent
@end



@interface DSHttpPerInvestmentListResule()
@property DSHttpPerInvestmentListContent *data;
@end



@implementation DSHttpPerInvestmentListCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpPerInvestmentListResule *result = (DSHttpPerInvestmentListResule *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpPerInvestmentListContent alloc]initWithDictionary:dic error:(NSError **)&error];
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
@implementation DSHttpPerInvestmentListResule
- (NSMutableArray *)getAllContent{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSPerInvestmentListInfo *info = [[DSPerInvestmentListInfo alloc]init];
        DSHttpPerInvestmentListDetail *webInfo = self.data.content[i];
        info.linedIn = webInfo.linedIn;
        info.cardNoBack = webInfo.cardNoBack;
        info.wechat = webInfo.wechat;
        info.pv = webInfo.pv;
        info.personalAssetsCertificate = webInfo.personalAssetsCertificate;
        info.videoUrl = webInfo.videoUrl;
        info.popular = webInfo.popular;
        info.name = webInfo.name;
        info.videoImage = webInfo.videoImage;
        info.videoImage = webInfo.videoImage;
        info.account = webInfo.account;
        info.id = webInfo.id;
        info.cardNoFront = webInfo.cardNoFront;
        info.phone = webInfo.phone;
        info.videoTitle = webInfo.videoTitle;
        info.avatar = webInfo.avatar;
        info.introduction = webInfo.introduction;
        info.createTime = webInfo.createTime;
        info.cardNo = webInfo.cardNo;
        info.cases = webInfo.cases;
        info.investMin = webInfo.investMin;
        info.investMax = webInfo.investMax;
        if (webInfo.followCount == nil) {
            info.followNum = @"0";
        }else{
            info.followNum = webInfo.followCount;
        }
        //info.followNum = webInfo.followNum;
        for (int j=0; j<webInfo.cats.count; j++) {
            DSAccountsInstituListCatsInfo *catsinfo = [[DSAccountsInstituListCatsInfo alloc]init];
            DSHttpPerInvestmentListCats *infos= webInfo.cats[j];
            catsinfo.catName = infos.catName;
            catsinfo.descriptions = infos.description;
           
            [info.cats addObject:catsinfo];
        }
        [arr addObject:info];
    }
    return arr;
}

@end