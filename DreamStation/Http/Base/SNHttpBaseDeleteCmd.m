//
//  SNHttpBaseDeleteCmd.m
//  DreamStation
//
//  Created by QPP on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseDeleteCmd.h"
#import "AFNetworking.h"
#import "DreamStation-Swift.h"


@implementation SNHttpBaseDeleteCmd
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
    
    
    AFHTTPRequestOperation *operation = [manager DELETE:(NSString *)[self getUrl] parameters:[self getBodyParam] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (responseObject!=nil){
            NSLog(@"resultJson:%@",[self DataTOjsonString:responseObject]);
        }
        
        
        
        [self onRequestSuccess:responseObject code:operation.response.statusCode];
        [self invokeComplete];
        //[self hidenHintView];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
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
