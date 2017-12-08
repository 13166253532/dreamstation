//
//  QSHttpBaseGetCmd.m
//  QiuShi
//
//  Created by wei wu on 14-9-26.
//  Copyright (c) 2014年 wei wu. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"
#import "AFNetworking.h"
//#import "DreamStation-Swift.h"

static NSString *const kHttpParamKey_sessionId = @"token";
NSString *const kHttpParamKey_pageNum = @"page";
NSString *const kHttpParamKey_pageSize = @"size";
NSString *const kHttpParamKey_address = @"address";
@implementation SNHttpBaseGetCmd
- (id)execute{
    
    return [self executeByOperationManager];
   
}
-(id)executeByOperationManager
{
    //[self showHintView:@"加载中..."];
    AFHTTPRequestOperationManager *manager = [self afnetworkOperationManager];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *auth = [self getAuthorization];
    if (auth.length>0){
        [requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    }
    manager.requestSerializer = requestSerializer;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     NSLog(@"requestJson:%@",[self DataTOjsonString:[self getBodyParam]]);
    
    AFHTTPRequestOperation *operation = [manager GET:(NSString *)[self getUrl]
                                          parameters:[self getBodyParam]
                                        success:^(AFHTTPRequestOperation *operation, id responseObject){
                                            
                                            if (responseObject!=nil){
                                                 NSLog(@"resultJson:%@",[self DataTOjsonString:responseObject]);
                                            }
                                            
                                            
                                            
                                            [self onRequestSuccess:responseObject code:operation.response.statusCode];
                                            [self invokeComplete];
                                            //[self hidenHintView];
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error){
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
                                        }];

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
