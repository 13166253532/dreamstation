//
//  DSHttpIsCollectionsCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/11.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpIsCollectionsCmd+Response.h"
#import "DSHttpIsCollectionsResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"
@interface DSHttpIsCollectionsContent : JSONModel
@property NSString<Optional> *status;
@property NSString<Optional> *msg;
@end
@implementation DSHttpIsCollectionsContent
@end

@interface DSHttpIsCollectionsResult ()
@property DSHttpIsCollectionsContent *data;
@end

@implementation DSHttpIsCollectionsCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpIsCollectionsResult *result = (DSHttpIsCollectionsResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpIsCollectionsContent alloc]initWithDictionary:dic error:(NSError **)&error];
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
@implementation DSHttpIsCollectionsResult

-(NSMutableArray *)getTheContent{
    NSMutableArray *arr = [NSMutableArray array];
    DSHttpCollectionsListInfo *info = [[DSHttpCollectionsListInfo alloc]init];
    DSHttpIsCollectionsContent *resuleDetail = self.data;
    info.status = resuleDetail.status;
    info.msg = resuleDetail.msg;
    [arr addObject:info];
    return arr;
}
@end