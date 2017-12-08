//
//  DSHttpActivitySignupCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpActivitySignupCmd+Response.h"
#import "DSHttpActivitySignupResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpActivitySignupResultDetail;
@interface DSHttpActivitySignupResultDetail : JSONModel
@property NSString<Optional>*result;
@end
@implementation DSHttpActivitySignupResultDetail
@end

@interface DSHttpActivitySignupResult()
@property DSHttpActivitySignupResultDetail *detail;
@end


@implementation DSHttpActivitySignupCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{

    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpActivitySignupResult *result = (DSHttpActivitySignupResult *)self.result;
    if (code>199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.detail = [[DSHttpActivitySignupResultDetail alloc]initWithDictionary:dic error:(NSError **)&error];
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

@implementation DSHttpActivitySignupResult
- (DSBaseActivityInfo *)getResult{
    DSHttpActivitySignupResultDetail *webInfo = self.detail;
    DSBaseActivityInfo *info = [[DSBaseActivityInfo alloc]init];
    info.isSuccess = webInfo.result;
    return info;
}
@end