//
//  DSHttpChangeParkPerInfoCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/9/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpChangeParkPerInfoCmd+Response.h"
#import "DSHttpChangeParkPerInfoResult.h"
@implementation DSHttpChangeParkPerInfoCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    if (code > 199&&code < 299) {
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


@implementation DSHttpChangeParkPerInfoResult

@end