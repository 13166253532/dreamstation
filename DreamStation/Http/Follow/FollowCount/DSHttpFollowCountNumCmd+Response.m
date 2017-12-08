//
//  DSHttpFollowCountNumCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/9/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpFollowCountNumCmd+Response.h"
#import "DSHttpFollowCountNumResule.h"
#import "JSONModel.h"

@interface DSHttpFollowCountNumResuleData : JSONModel
@property NSString<Optional> *count;
@end
@implementation DSHttpFollowCountNumResuleData
@end

@interface DSHttpFollowCountNumResule ()
@property DSHttpFollowCountNumResuleData *data;
@end


@implementation DSHttpFollowCountNumCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpFollowCountNumResule *result = (DSHttpFollowCountNumResule *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpFollowCountNumResuleData alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpFollowCountNumResule
- (NSString *)getCount{
    return self.data.count;
}


@end