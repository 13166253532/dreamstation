//
//  DSHttpIsFollowCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpIsFollowCmd+Response.h"
#import "DSHttpIsFollowResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@interface DSHttpIsFollowContent : JSONModel
@property NSString<Optional> *result;
@property NSString<Optional> *error;
@property NSString<Optional> *error_description;
@end
@implementation DSHttpIsFollowContent
@end

@interface DSHttpIsFollowResult()
@property DSHttpIsFollowContent *data;
@end


@implementation DSHttpIsFollowCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpIsFollowResult *result = (DSHttpIsFollowResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
         result.data = [[DSHttpIsFollowContent alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpIsFollowResult
- (NSString *)getAllContent{
    return self.data.result;
}

@end

