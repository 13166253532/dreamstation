//
//  DSHttpProjectStatusCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/9/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProjectStatusCmd+Response.h"
#import "DSHttpProjectStatusResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"




@protocol DSHttpProjectStatusData;
@interface  DSHttpProjectStatusData: JSONModel
@property NSString<Optional>*status;
@property NSString<Optional>*userId;
@property NSString<Optional>*reason;
@property NSString<Optional>*id;
@property NSString<Optional>*role;
@property NSString<Optional>*applyTime;
@property NSString<Optional>*applyLogin;
@property NSString<Optional>*message;
@end
@implementation DSHttpProjectStatusData
@end


@interface DSHttpProjectStatusResult()
@property DSHttpProjectStatusData *data;
@end

@implementation DSHttpProjectStatusCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpProjectStatusResult *result = (DSHttpProjectStatusResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpProjectStatusData alloc]initWithDictionary:dic error:(NSError **)&error];
        
        
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


@implementation DSHttpProjectStatusResult
- (NSString *)getProjectStatus{
    return self.data.status;
}

@end