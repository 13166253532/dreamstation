//
//  DSHttpIsFollowCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpIsFollowCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_IsFollow_model;
extern NSString *const kHttpParamKey_IsFollow_investorId;
extern NSString *const kHttpParamKey_IsFollow_investmentId;
extern NSString *const kHttpParamKey_IsFollow_productId;
extern NSString *const kHttpParamKey_IsFollow_productUserId;

