//
//  SMCommandComplete.h
//  HttpExamples
//
//  Created by wei wu on 14-8-25.
//  Copyright (c) 2014年 misapprehand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommandProtocol.h"

@class RequestResult;
@interface SMCommandComplete : NSObject<HttpCommandCompleteDelegate>
-(void)waitForComplete;
@end
