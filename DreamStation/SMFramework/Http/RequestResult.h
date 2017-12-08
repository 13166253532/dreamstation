//
//  RequestResult.h
//  HttpExamples
//
//  Created by wei wu on 14-7-17.
//  Copyright (c) 2014年 www.smilingmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,RequestResultState){
    kRequestResultNetworkError,
    kRequestResultSuccess,
    kRequestResultFail,
    kRequestResultCanceled
};
FOUNDATION_EXPORT NSString const *kRequestResultKey_State;

@interface RequestResult : NSObject
@property (copy) void(^loginCompleteBlock)(RequestResult*,id);
-(bool) isOk;
@property(retain, nonatomic)NSString *errMsg;
@property NSString * errCode;
@property RequestResultState resultState;
@property BOOL accessTokenValid;
@end
