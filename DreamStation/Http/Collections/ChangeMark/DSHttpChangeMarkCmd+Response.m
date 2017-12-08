//
//  DSHttpChangeMarkCmd+Response.m
//  DreamStation
//
//  Created by xjb on 2016/12/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpChangeMarkCmd+Response.h"
#import "DSHttpChangeMarkRecule.h"
@implementation DSHttpChangeMarkCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    //DSHttpCollectionListResule *result = (DSHttpCollectionListResule *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
       // result.data = [[DSHttpCollectionListContent alloc]initWithDictionary:dic error:(NSError **)&error];
        
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


@implementation DSHttpChangeMarkRecule

@end
