//
//  DSHttpAccountStatusCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpAccountStatusCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_AccountStatus_user_id;
