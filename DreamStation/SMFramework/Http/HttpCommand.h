//
//  HttpCommad.h
//  HttpExamples
//
//  Created by wei wu on 14-7-18.
//  Copyright (c) 2014年 www.smilingmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommandProtocol.h"

@class RequestResult;
typedef NS_ENUM(NSInteger, AuthorizationState) {
    AuthorizationNull=0,//不加Authorization
    AuthorizationToken,//需要AccessToken
    AuthorizationClientSecret,//需要client id 和 client secret
};



@interface HttpCommand : NSObject <HttpCommandProtocol>
{
    @protected
    NSDictionary *requestInfo_;
    RequestResult *result_;
}
@property(nonatomic,retain) NSDictionary *requestInfo;
@property(nonatomic,retain) NSDictionary *urlInfo;
@property(nonatomic,strong) NSMutableDictionary *param;
@property(nonatomic,retain) RequestResult *result;
@property(nonatomic,retain) id<HttpCommandProtocol> delegate;
@property(nonatomic,retain) id<HttpCommandCompleteDelegate> completeDelegate;
@property NSString *version;
@property(nonatomic) BOOL needVerify;
@property(nonatomic) AuthorizationState authorState;
@property BOOL needOtherParams;

-(instancetype)initWithVersion:(NSString *)version;
-(instancetype)initWithVerify:(BOOL)needVerify;
-(instancetype)initWithAuthorizationState:(AuthorizationState)state;
-(instancetype)initWithOtherParamsNeed:(BOOL)needOtherParams;
-(instancetype)initWithVerify:(BOOL)needVerify withOtherParamsNeed:(BOOL)needOtherParams;
-(void)invokeComplete;
-(NSString *)getBaseUrl;
-(NSString *)getActionUrl;
-(NSDictionary *)getRequestParam;
@property (copy) void(^loginCompleteBlock)(RequestResult*,id);
@property (copy) void(^loginCancleBlock)();


+(HttpCommand *) httpCommandWithVersion:(NSString *)version;


@end
