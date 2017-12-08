//
//  DSHttpGetStatisticsCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpGetStatisticsCmd+Response.h"
#import "DSHttpGetStrtisticsResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@interface DSHttpGetStrtisticsContent : JSONModel
@property NSString<Optional> *count;
@end
@implementation DSHttpGetStrtisticsContent
@end
@interface DSHttpGetStrtisticsResult ()
@property DSHttpGetStrtisticsContent *data;
@end

@implementation DSHttpGetStatisticsCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpGetStrtisticsResult *result = (DSHttpGetStrtisticsResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpGetStrtisticsContent alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpGetStrtisticsResult
- (NSString *)getAllTheContent{
    return self.data.count;
}
@end
