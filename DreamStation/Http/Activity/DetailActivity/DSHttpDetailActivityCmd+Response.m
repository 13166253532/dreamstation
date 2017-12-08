//
//  DSHttpDetailActivityCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpDetailActivityCmd+Response.h"
#import "DSHttpDetailActivityResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpDetailActivityUser;
@interface DSHttpDetailActivityUser : JSONModel
@property NSString<Optional> *userId;
@property NSString<Optional> *name;
@property NSString<Optional> *phone;
@property NSString<Optional> *company;
@property NSString<Optional> *position;
@property NSString<Optional> *landLine;
@end
@implementation DSHttpDetailActivityUser
@end

@protocol DSHttpDetailActivityValue;
@interface DSHttpDetailActivityValue : JSONModel
@property NSString<Optional> *id;
@property NSString<Optional> *description;
@property NSString<Optional> *builder;
@property NSString<Optional> *userSign;
@property NSString<Optional> *address;
@property NSString<Optional> *endTime;
@property NSString<Optional> *smartImage;
@property NSString<Optional> *beginTime;
@property NSString<Optional> *sortNumber;
@property NSString<Optional> *name;
@property NSString<Optional> *status;
@property NSMutableArray<Optional,DSHttpDetailActivityUser> *users;
@end
@implementation DSHttpDetailActivityValue
@synthesize description;
@end



@interface DSHttpDetailActivityResult()
@property DSHttpDetailActivityValue *data;
@end

@implementation DSHttpDetailActivityCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{

    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpDetailActivityResult *result = (DSHttpDetailActivityResult *)self.result;
    if (code>199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpDetailActivityValue alloc]initWithDictionary:dic error:(NSError **)&error];
        if (error) {
            [self onRequestFailed:error];
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


@implementation DSHttpDetailActivityResult

- (DSDetailActivityInfo *)getAllData{

    DSDetailActivityInfo *info = [[DSDetailActivityInfo alloc]init];
    DSHttpDetailActivityValue *webInfo = self.data;
    
    info.id = webInfo.id;
    info.description2 = webInfo.description;
    info.builder = webInfo.builder;
    info.userSign = webInfo.userSign;
    info.address = webInfo.address;
    info.endTime = webInfo.endTime;
    info.smartImage = webInfo.smartImage;
    info.beginTime = webInfo.beginTime;
    info.sortNumber = webInfo.sortNumber;
    info.name = webInfo.name;
    info.status = webInfo.status;
    
    return info;
    
}

@end