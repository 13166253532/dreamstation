//
//  HTHttpConfig.h
//  HiTeacher
//
//  Created by QPP on 16/5/11.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "HttpConfig.h"
static NSString *HIHttpVersion_v1 = @"HIHttpVersion_v1";

@interface HTHttpConfig : HttpConfig
+(HTHttpConfig *)sharedInstance;
+(NSString *)registerKey;
@property BOOL isout;
@end
