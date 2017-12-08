//
//  DSHttpAccountStatusCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpAccountStatusCmd+Response.h"
#import "DSHttpAccountStatusResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpAccountStatusData;
@interface  DSHttpAccountStatusData: JSONModel
@property NSString<Optional>*status;
@end
@implementation DSHttpAccountStatusData
@end


@interface DSHttpAccountStatusResult()
@property DSHttpAccountStatusData *data;
@end


@implementation DSHttpAccountStatusCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpAccountStatusResult *result = (DSHttpAccountStatusResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpAccountStatusData alloc]initWithDictionary:dic error:(NSError **)&error];
        
        
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


@implementation DSHttpAccountStatusResult

- (NSString *)getUserStatus{
    return self.data.status;
}

@end