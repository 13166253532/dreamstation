//
//  DSHttpFollowNumCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpFollowNumCmd+Response.h"
#import "DSHttpFollowNumResule.h"
#import "JSONModel.h"
@interface DSHttpFollowNumResuleData : JSONModel
@property NSString<Optional> *count;
@end
@implementation DSHttpFollowNumResuleData
@end
@interface DSHttpFollowNumResule ()
@property DSHttpFollowNumResuleData *data;
@end
@implementation DSHttpFollowNumCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpFollowNumResule *result = (DSHttpFollowNumResule *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
         result.data = [[DSHttpFollowNumResuleData alloc]initWithDictionary:dic error:(NSError **)&error];
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
@implementation DSHttpFollowNumResule
-(NSString *)getTheCount{
    return self.data.count;
}
@end