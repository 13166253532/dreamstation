//
//  DSHttpMyActivityCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpMyActivityCmd+Response.h"
#import "DSHttpMyActivityResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpMyActivityDetail;
@interface DSHttpMyActivityDetail : JSONModel
@property NSString<Optional> *id;
@property NSString<Optional> *name;
@property NSString<Optional> *address;
@property NSString<Optional> *beginTime;
@property NSString<Optional> *endTime;
@property NSString<Optional> *description;
@property NSString<Optional> *smartImage;
@property NSString<Optional> *status;
@property NSString<Optional> *sortNumber;
@end
@implementation DSHttpMyActivityDetail
@synthesize description;
@end

@interface DSHttpMyActivityContent : JSONModel
@property NSMutableArray<DSHttpMyActivityDetail> *content;
@end
@implementation DSHttpMyActivityContent
@end

@interface DSHttpMyActivityResult()
@property DSHttpMyActivityContent *data;
@end

@implementation DSHttpMyActivityCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{

    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpMyActivityResult *result = (DSHttpMyActivityResult *)self.result;
    if (code>199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpMyActivityContent alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpMyActivityResult

- (NSMutableArray *)getAllContent{

    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSMyActivityInfo *info = [[DSMyActivityInfo alloc]init];
        DSHttpMyActivityDetail *webInfo = self.data.content[i];
        info.id = webInfo.id;
        info.name = webInfo.name;
        info.address = webInfo.address;
        info.beginTime = webInfo.beginTime;
        info.endTime = webInfo.endTime;
        info.descriptionn = webInfo.description;
        info.smartImage = webInfo.smartImage;
        info.status = webInfo.status;
        info.sortNumber = webInfo.sortNumber;
        [arr addObject:info];
    }
    return arr;
}

@end

