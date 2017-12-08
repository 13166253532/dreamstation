//
//  DSHttpActivitiesListCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpActivitiesListCmd+Response.h"
#import "DSHttpActivitiesListResule.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpActivitiesListDetail;
@interface DSHttpActivitiesListDetail : JSONModel
@property NSString<Optional> *id;
@property NSString<Optional> *description;
@property NSString<Optional> *builder;
@property NSString<Optional> *userSign;
@property NSString<Optional> *address;
@property NSString<Optional> *endTime;
@property NSString<Optional> *createTime;
@property NSString<Optional> *smartImage;
@property NSString<Optional> *beginTime;
@property NSString<Optional> *sortNumber;
@property NSString<Optional> *name;
@property NSString<Optional> *status;
@end
@implementation DSHttpActivitiesListDetail
@synthesize description;
@end


@interface DSHttpActivitiesListContent : JSONModel
@property NSMutableArray<DSHttpActivitiesListDetail> *content;
@end
@implementation DSHttpActivitiesListContent
@end



@interface DSHttpActivitiesListResule ()
@property DSHttpActivitiesListContent *data;
@end


@implementation DSHttpActivitiesListCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{

    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpActivitiesListResule *result = (DSHttpActivitiesListResule *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpActivitiesListContent alloc]initWithDictionary:dic error:(NSError **)&error];
        
        
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


@implementation DSHttpActivitiesListResule

- (NSMutableArray *)getAllContent{

    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSActivitiesListInfo *info = [[DSActivitiesListInfo alloc]init];
        DSHttpActivitiesListDetail *webInfo = self.data.content[i];
        info.id = webInfo.id;
        info.description1 = webInfo.description;
        info.builder = webInfo.builder;
        info.userSign = webInfo.userSign;
        info.address = webInfo.address;
        info.endTime = webInfo.endTime;
        info.createTime = webInfo.createTime;
        info.smartImage = webInfo.smartImage;
        info.beginTime = webInfo.beginTime;
        info.sortNumber = webInfo.sortNumber;
        info.name = webInfo.name;
        info.status = webInfo.status;
        [arr addObject:info];
    }
    return arr;
}

@end