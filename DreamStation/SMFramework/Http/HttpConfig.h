//
//  HttpConfig.h
//  HttpExamples
//
//  Created by wei wu on 14-7-18.
//  Copyright (c) 2014年 www.smilingmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpConfig : NSObject
-(NSString const *)getServerAddress:(NSString *)addressKey;
@property NSString *accessToken;
@end
