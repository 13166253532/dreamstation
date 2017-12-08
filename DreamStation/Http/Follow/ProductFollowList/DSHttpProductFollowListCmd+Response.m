//
//  DSHttpProductFollowListCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProductFollowListCmd+Response.h"
#import "DSHttpProductFollowListResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpProductFollowListResultCategories;
@interface DSHttpProductFollowListResultCategories : JSONModel
@property NSString<Optional> *description;
@property NSString<Optional> *catName;
@end
@implementation DSHttpProductFollowListResultCategories
@synthesize description;
@end

@protocol DSHttpProductFollowListDetail;
@interface DSHttpProductFollowListDetail : JSONModel
@property NSString<Optional>*productName;
@property NSString<Optional>*categories;
@property NSString<Optional>*investmentUserId;
@property NSString<Optional>*investmentUserIds;
@property NSString<Optional>*productUrl;
@property NSString<Optional>*productId;
@property NSString<Optional>*productUserId;
@property NSString<Optional>*orderModel;
@property NSString<Optional>*userGroupId;
@property NSString<Optional>*orderId;
@property NSString<Optional>*itemId;
@property NSString<Optional>*introduceImg;
@property NSString<Optional>*investorAccount;
@property NSString<Optional>*investorType;
@property NSString<Optional>*videoUrl;
@property NSString<Optional>*introduceDesc;
@property NSString<Optional>*companyName;
@property NSString<Optional>*userName;
@property NSString<Optional>*avaterUrl;
@property NSString<Optional>*phase;
@property NSString<Optional>*domain;
@property NSString<Optional>*investorId;
@end
@implementation DSHttpProductFollowListDetail
@end

@interface DSHttpProductFollowListContent : JSONModel
@property NSMutableArray<DSHttpProductFollowListDetail>*contents;
@end
@implementation DSHttpProductFollowListContent
@end

@interface DSHttpProductFollowListResult()
@property DSHttpProductFollowListContent *data;
@property NSMutableArray *list;
@end

@implementation DSHttpProductFollowListCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpProductFollowListResult *result = (DSHttpProductFollowListResult *)self.result;
    if (code>199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpProductFollowListContent alloc]initWithDictionary:dic error:(NSError **)&error];
        if(error){
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


@implementation DSHttpProductFollowListResult
- (NSMutableArray *)getAllContent{

    self.list = [NSMutableArray array];
    for (int i = 0; i<self.data.contents.count; i++) {
        DSProductFollowListInfo *info = [[DSProductFollowListInfo alloc]init];
        DSHttpProductFollowListDetail *webInfo = self.data.contents[i];
        info.productName = webInfo.productName;
        if (webInfo.categories != nil) {
            NSData *data = [webInfo.categories dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableArray *list = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *catList = [NSMutableArray array];
            for (int i=0; i<list.count; i++) {
                DSHttpProductFollowListResultCategories *categories=[[DSHttpProductFollowListResultCategories alloc]initWithDictionary:list[i] error:nil];
                DSProductFollowCategoriesInfo *infos=[[DSProductFollowCategoriesInfo alloc]init];
                infos.catName = categories.catName;
                infos.descriptions = categories.description;
                [catList addObject:infos];
            }
           info.categor = catList;
        }
        info.investorAccount = webInfo.investorAccount;
        info.introduceImg = webInfo.introduceImg;
        info.investorType = webInfo.investorType;
        info.videoUrl = webInfo.videoUrl;
        info.introduceDesc = webInfo.introduceDesc;
        info.companyName = webInfo.companyName;
        info.userName = webInfo.userName;
        info.investmentUserId = webInfo.investmentUserId;
        info.investmentUserIds = webInfo.investmentUserIds;
        info.productUrl = webInfo.productUrl;
        info.productId = webInfo.productId;
        info.productUserId = webInfo.productUserId;
        info.orderModel = webInfo.orderModel;
        info.userGroupId = webInfo.userGroupId;
        info.orderId = webInfo.orderId;
        info.itemId = webInfo.itemId;
        info.avaterUrl = webInfo.avaterUrl;
        info.phase = webInfo.phase;
        info.domain = webInfo.domain;
        info.investorId = webInfo.investorId;
        [self.list addObject:info];
    }
    return self.list;
}
@end