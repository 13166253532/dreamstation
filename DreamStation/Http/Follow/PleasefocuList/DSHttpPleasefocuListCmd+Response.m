//
//  DSHttpPleasefocuListCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPleasefocuListCmd+Response.h"
#import "DSHttpPleasefocuListResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"


@protocol DSHttpPleasefocuListResultCategories;
@interface DSHttpPleasefocuListResultCategories : JSONModel
@property NSString<Optional> *description;
@property NSString<Optional> *catName;
@property NSString<Optional> *name;
@end
@implementation DSHttpPleasefocuListResultCategories
@synthesize description;
@end

@protocol DSHttpPleasefocuListResulecontent;
@interface DSHttpPleasefocuListResulecontent : JSONModel
@property NSString<Optional> *orderId;
@property NSString<Optional> *storeAddress;
@property NSString<Optional> *wechat;
@property NSString<Optional> *itemId;
@property NSString<Optional> *introduceImg;
@property NSString<Optional> *storeCompany;
@property NSString<Optional> *productUserId;
@property NSString<Optional> *investorAccount;
@property NSString<Optional> *investorType;
@property NSString<Optional> *storeName;
@property NSString<Optional> *time;
@property NSString<Optional> *videoUrl;
@property NSString<Optional> *productId;
@property NSString<Optional> *investmentUserIds;
@property NSString<Optional> *introduceDesc;
@property NSString<Optional> *phase;
@property NSString<Optional> *avaterUrl;
@property NSString<Optional> *domain;
@property NSString<Optional> *storeAccount;
@property NSString<Optional> *productUrl;
@property NSString<Optional> *userGroupId;
@property NSString<Optional> *companyName;
@property NSString<Optional> *productName;
@property NSString<Optional> *userName;
@property NSString<Optional> *categories;
@property NSString<Optional> *orderModel;
@property NSString<Optional> *videoUrl4Provider;
@end
@implementation DSHttpPleasefocuListResulecontent
@end


@interface DSHttpPleasefocuListResuleData : JSONModel
@property NSMutableArray<DSHttpPleasefocuListResulecontent>*content;
@property NSString<Optional> *size;
@end
@implementation DSHttpPleasefocuListResuleData
@end

@interface DSHttpPleasefocuListResult ()
@property DSHttpPleasefocuListResuleData *data;
@end


@implementation DSHttpPleasefocuListCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpPleasefocuListResult *result = (DSHttpPleasefocuListResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpPleasefocuListResuleData alloc]initWithDictionary:dic error:(NSError **)&error];
        if (error) {
            [self onRequestFailed:error];
            return;
        }
    }else{
        NSString *memo = [dic objectForKey:@"error"];
        [self.result setResultState:kRequestResultFail];
        [self.result setErrMsg:memo];
    }
}
- (void)onRequestFailed:(NSError *)error{
    [self.result setErrMsg:[error localizedDescription]];
    [self.result setResultState:kRequestResultSuccess];
}

@end



@implementation DSHttpPleasefocuListResult

- (NSMutableArray *)getAllContent{
    
    NSMutableArray *list = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSPleasefocuListInfo *info = [[DSPleasefocuListInfo alloc]init];
        DSHttpPleasefocuListResulecontent *webInfo = [[DSHttpPleasefocuListResulecontent alloc]init];
        webInfo = self.data.content[i];
        info.orderId = webInfo.orderId;
        info.storeAddress = webInfo.storeAddress;
        info.wechat = webInfo.wechat;
        info.itemId = webInfo.itemId;
        info.introduceImg = webInfo.introduceImg;
        info.storeCompany = webInfo.storeCompany;
        info.productUserId = webInfo.productUserId;
        info.investorAccount = webInfo.investorAccount;
        info.investorType = webInfo.investorType;
        info.storeName = webInfo.storeName;
        info.time = webInfo.time;
        info.videoUrl = webInfo.videoUrl;
        info.productId = webInfo.productId;
        info.investmentUserIds = webInfo.investmentUserIds;
        info.introduceDesc = webInfo.introduceDesc;
        info.phase = webInfo.phase;
        info.avaterUrl = webInfo.avaterUrl;
        info.domain = webInfo.domain;
        info.storeAccount = webInfo.storeAccount;
        info.userGroupId = webInfo.userGroupId;
        info.companyName = webInfo.companyName;
        info.productName = webInfo.productName;
        info.productUrl = webInfo.productUrl;
        info.userName = webInfo.userName;
        info.videoUrl4Provider = webInfo.videoUrl4Provider;
        //info.categories = webInfo.categories;
        if (webInfo.categories != nil) {
            NSData *data = [webInfo.categories dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableArray *lists = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (int i=0; i<lists.count; i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic = lists[i];
                DSHttpPleasefocuListResultCategories *result = [[DSHttpPleasefocuListResultCategories alloc]initWithDictionary:dic error:nil];
                DSPleasefocuListCatInfo *catInfo = [[DSPleasefocuListCatInfo alloc]init];
                if (result.catName == nil) {
                    catInfo.name = result.name;
                }else{
                    catInfo.name = result.catName;
                }
                catInfo.descriptions = result.description;
                [info.catArray addObject:catInfo];
            }
        }
        info.orderModel = webInfo.orderModel;
        [list addObject:info];
    }
   return list;
    
    
}





@end
