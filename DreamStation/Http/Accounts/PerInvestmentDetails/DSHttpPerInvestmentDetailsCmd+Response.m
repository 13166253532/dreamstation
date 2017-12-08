//
//  DSHttpPerInvestmentDetailsCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPerInvestmentDetailsCmd+Response.h"
#import "DSHttpPerInvestmentDetailsResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpPerInvestmentDetailsCats;
@interface DSHttpPerInvestmentDetailsCats : JSONModel
@property NSString<Optional> *catName;
@property NSString<Optional> *description;
@end
@implementation DSHttpPerInvestmentDetailsCats
@synthesize description;
@end


@interface DSHttpPerInvestmentDetailsContent : JSONModel
@property NSString<Optional> *linedIn;
@property NSString<Optional> *cardNoBack;
@property NSString<Optional> *wechat;
@property NSString<Optional> *pv;
@property NSString<Optional> *personalAssetsCertificate;
@property NSString<Optional> *videoUrl;
@property NSString<Optional> *popular;
@property NSString<Optional> *name;
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
@property NSString<Optional> *investMin;
@property NSString<Optional> *investMax;@property NSMutableArray<DSHttpPerInvestmentDetailsCats> *cats;
@end
@implementation DSHttpPerInvestmentDetailsContent
@end


@interface DSHttpPerInvestmentDetailsResult()
@property DSHttpPerInvestmentDetailsContent *data;

@end

@implementation DSHttpPerInvestmentDetailsCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
     //DSHttpPerInvestmentDetailsResult *result = (DSHttpPerInvestmentDetailsResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        //result.data = [[DSHttpPerInvestmentDetailsContent alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpPerInvestmentDetailsResult

- (NSMutableArray *)getAllContent{
    NSMutableArray *arr = [NSMutableArray array];
//    DSPerInvestmentListInfo *info = [[DSPerInvestmentListInfo alloc]init];
    DSHttpPerInvestmentDetailsContent *webInfo = self.data;

    
    for (int j=0; j<webInfo.cats.count; j++) {
        DSAccountsInstituListCatsInfo *catsinfo = [[DSAccountsInstituListCatsInfo alloc]init];
        DSHttpPerInvestmentDetailsCats *infos= webInfo.cats[j];
        catsinfo.catName = infos.catName;
        catsinfo.descriptions = infos.description;
      
    }
    return arr;
}

@end