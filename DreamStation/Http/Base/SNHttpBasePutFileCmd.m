//
//  DTPHttpBasePutCmd.m
//  DTPocket
//
//  Created by sqb on 15/4/1.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import "SNHttpBasePutFileCmd.h"
#import "AFNetworking.h"
#import "NSData+MineType.h"

static NSString *const kHttpParamKey_sessionId = @"token";


@implementation SNHttpBasePutFileCmd
- (id)execute{
   
    return [self executeByOperationManager];

}
-(id)executeByOperationManager
{
    // manager needs to be init'd with a valid baseURL
    //[self showHintView:@"加载中..."];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *auth = [self getAuthorization];
    if (auth.length>0){
        [requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    }
    manager.requestSerializer = requestSerializer;
    
    
    
   NSMutableURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[self getUrl] parameters:[super getRequestParam] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       [self createFormData:formData];
   } error:nil];
    
    AFHTTPRequestOperation *requestOperation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil){
            NSLog(@"resultJson:%@",[self DataTOjsonString:responseObject]);
        }
        
        [self onRequestSuccess:responseObject code:operation.response.statusCode];
        [self invokeComplete];
        //[self hidenHintView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
    
    // fire the request
    [requestOperation start];
    return requestOperation;
}

-(void)createFormData:(id<AFMultipartFormData>) formData
{
    if (_fileData) {
        [formData appendPartWithFileData:_fileData name:_keyName fileName:_fileName mimeType:[_fileData mimeType]];
    }
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
    //    if (YES == self.needVerify) {
    //        HttpConfig *httpConfig = [self httpConfig];
    //        dict[kHttpParamKey_sessionId] = httpConfig.accessToken;
    //    }
    return dict;
}
-(NSDictionary *)getBodyParam{
    return [self getRequestParam];
}
-(NSDictionary *)getRequestUrlParam{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (YES == self.needVerify) {
        HttpConfig *httpConfig = [self httpConfig];
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

@end
