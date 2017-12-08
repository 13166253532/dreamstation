//
//  SMBaseHttpComplete.h
//  HttpExamples
//
//  Created by wei wu on 14-9-2.
//  Copyright (c) 2014年 misapprehand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommandProtocol.h"

@class RequestResult;


typedef void (^SMHttpUIUpdateBlock)(RequestResult *,id);

@interface SMBaseHttpComplete : NSObject<HttpCommandCompleteDelegate>
//method
-(id) initWithBlock:(void(^)(RequestResult *,id userInfo))completeBlock withUserInfo:(id)userInfo;
-(void)updateUI:(RequestResult *)result;
//property
@property (copy) void (^completeBlock)(RequestResult *,id);


@end