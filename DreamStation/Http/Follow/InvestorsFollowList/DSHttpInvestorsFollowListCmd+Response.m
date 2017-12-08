//
//  DSHttpInvestorsFollowListCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpInvestorsFollowListCmd+Response.h"
#import "DSHttpInvestorsFollowListResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpInvestorsFollowListCategories;
@interface DSHttpInvestorsFollowListCategories : JSONModel
@property NSString<Optional> *description;
@property NSString<Optional> *catName;
@end
@implementation DSHttpInvestorsFollowListCategories
@synthesize description;
@end


@protocol DSHttpInvestorsFollowListDetail;
@interface DSHttpInvestorsFollowListDetail : JSONModel
@property NSString<Optional> *productName;
@property NSString<Optional> *categories;
@property NSString<Optional> *investmentUserId;
@property NSString<Optional> *productUrl;
@property NSString<Optional> *productId;
@property NSString<Optional> *productUserId;
@property NSString<Optional> *orderModel;
@property NSString<Optional> *userGroupId;
@property NSString<Optional> *orderId;
@property NSString<Optional> *itemId;
@property NSString<Optional> *videoUrl;
@property NSString<Optional> *videoUrl4Provider;
@end
@implementation DSHttpInvestorsFollowListDetail

@end


@interface DSHttpInvestorsFollowListContent : JSONModel
@property NSMutableArray<DSHttpInvestorsFollowListDetail> *content;
@end
@implementation DSHttpInvestorsFollowListContent
@end

@interface DSHttpInvestorsFollowListResult ()
@property DSHttpInvestorsFollowListContent *data;
@property NSMutableArray *list;
@end

@implementation DSHttpInvestorsFollowListCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpInvestorsFollowListResult *result = (DSHttpInvestorsFollowListResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpInvestorsFollowListContent alloc]initWithDictionary:dic error:(NSError **)&error];
        
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


@implementation DSHttpInvestorsFollowListResult

- (NSMutableArray *)getAllContent{
    self.list = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSInvestorsFollowListInfo *info = [[DSInvestorsFollowListInfo alloc]init];
        DSHttpInvestorsFollowListDetail *webInfo = self.data.content[i];
        info.productName = webInfo.productName;
        //info.categories = [self getCategories:webInfo.categories];
        
//        for (int j=0; j<[self getCategories:webInfo.categories].count; j++) {
//            DSHttpInvestorsFollowListCategories *cat = [[DSHttpInvestorsFollowListCategories alloc]initWithDictionary:[self getCategories:webInfo.categories][j] error:nil];
//            NSLog(@"%@",cat.catName);
//        }
        if (webInfo.categories != nil)   {
            NSData *data = [webInfo.categories dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableArray *list = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *catList = [NSMutableArray array];
            for (int i=0; i<list.count; i++) {
                DSHttpInvestorsFollowListCategories *categories=[[DSHttpInvestorsFollowListCategories alloc]initWithDictionary:list[i] error:nil];
                DSInvestorsCategoriesInfo *infos=[[DSInvestorsCategoriesInfo alloc]init];
                infos.catName = categories.catName;
                infos.descriptio = categories.description;
                //NSLog(@"%@",infos.descriptio);
                [catList addObject:infos];
            }
            info.categories = catList;
        }
        info.investmentUserId = webInfo.investmentUserId;
        info.productUrl = webInfo.productUrl;
        info.productId = webInfo.productId;
        info.productUserId = webInfo.productUserId;
        info.orderModel = webInfo.orderModel;
        info.userGroupId = webInfo.userGroupId;
        info.orderId = webInfo.orderId;
        info.itemId = webInfo.itemId;
        info.videoUrl = webInfo.videoUrl;
        info.videoUrl4Provider = webInfo.videoUrl4Provider;
        [self.list addObject:info];
    }
    NSLog(@"%ld",(unsigned long)self.list.count);
    return self.list;
}

- (NSMutableArray *)getCategories:(NSString *)string{
    NSString *string1 = [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSArray *b = [string2 componentsSeparatedByString:@","];
    NSMutableArray *arr=[b mutableCopy] ;
    return arr;
}




@end
