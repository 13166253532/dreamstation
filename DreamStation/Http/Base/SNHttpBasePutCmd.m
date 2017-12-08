//
//  SNHttpBasePutCmd.m
//  soccernotes
//
//  Created by sqb on 15/8/11.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import "SNHttpBasePutCmd.h"
#import "AFNetWorking.h"
#import "SMHttp.h"

static NSString *const kHttpParamKey_sessionId = @"token";

@implementation SNHttpBasePutCmd
- (id)execute{
    
    return [self executeByOperationManager];

}
-(id)executeByOperationManager
{
    //[self showHintView:@"加载中..."];
    AFHTTPRequestOperationManager *manager = [self afnetworkOperationManager];
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    //    requestSerializer.timeoutInterval = 10;
    
    NSString *auth = [self getAuthorization];
    if (auth.length>0){
        [requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    }
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.securityPolicy.allowInvalidCertificates=YES;
    manager.securityPolicy.validatesDomainName=NO;
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/json",@"application/json",@"text/plain",@"text/html", nil];
    
    NSLog(@"getBodyParam:%@",[self DataTOjsonString:[self getBodyParam]]);
    
    AFHTTPRequestOperation *operation = [manager PUT:(NSString *)[self getUrl] parameters:[self getBodyParam] success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (responseObject!=nil){
            NSLog(@"resultJson:%@",[self DataTOjsonString:responseObject]);
        }
        [self onRequestSuccess:responseObject code:operation.response.statusCode];
        [self invokeComplete];
        //[self hidenHintView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"code:%d",operation.response.statusCode);
        [self judgeTokenExpired:operation.response.statusCode];
        if (operation.responseObject!=nil){
            NSLog(@"resultJson:%@",[self DataTOjsonString:operation.responseObject]);
            [self onRequestSuccess:operation.responseObject code:operation.response.statusCode];
        } else {
            [self onRequestFailed:error];
            NSLog ( @"operation: %@" , operation. responseString );
        }
        [self invokeComplete];
        //[self hidenHintView];
    } ];
    [operation start];
    return operation;
}
-(AFHTTPRequestOperationManager *)afnetworkOperationManager
{
    return [AFHTTPRequestOperationManager manager];
}

-(NSDictionary *)getRequestParam{
    NSMutableDictionary *dict = (NSMutableDictionary *)[super getRequestParam];
    if (nil == dict) {
        dict = [NSMutableDictionary dictionary];
    }
    return dict;
}
-(NSDictionary *)getBodyParam{
    return [self getRequestParam];
}
-(NSDictionary *)getRequestUrlParam{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (YES == self.needVerify) {
        HttpConfig *httpConfig = [self httpConfig];
        NSAssert(nil != httpConfig.accessToken , @"accessToken must not nil");
        dict[kHttpParamKey_sessionId] = httpConfig.accessToken;
    }
    return dict;
}
-(NSString *)getParamUrl
{
    NSString * paramUrl = [[NSString alloc]init];
    NSDictionary *dict = [self getRequestUrlParam];
    if(nil != dict){
        for(NSString *key in dict.allKeys){
            paramUrl = [paramUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[dict valueForKey:key]]];
        }
    }
    if (paramUrl.length>0) {
        return [paramUrl substringToIndex:paramUrl.length-1];
    }else
    {
        return nil;
    }
}

-(NSMutableDictionary *)getRequestUrlOtherParam{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (YES == self.needOtherParams) {
        dict = [[self getRequestParam] mutableCopy];
    }
    return dict;
}

-(NSString*)getOtherParamUrl
{
    NSString * paramUrl = [[NSString alloc]init];
    NSMutableDictionary *dict = [self getRequestUrlOtherParam];
    if(nil != dict){
        for(NSString *key in dict.allKeys){
            paramUrl = [paramUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[dict valueForKey:key]]];
        }
    }
    //    [dict removeAllObjects];
    if (paramUrl.length>0) {
        return [paramUrl substringToIndex:paramUrl.length-1];
    }else
    {
        return nil;
    }
}


@end
