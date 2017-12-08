//
//  DSHttpAddApplyAccountCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpAddApplyAccountCmd+Response.h"
#import "DSHttpAddApplyAccountResult.h"


@implementation DSHttpAddApplyAccountCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{

    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    if (code>199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
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

@implementation DSHttpAddApplyAccountResult

@end

