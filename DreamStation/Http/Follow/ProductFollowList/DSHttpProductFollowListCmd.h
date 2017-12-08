//
//  DSHttpProductFollowListCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpProductFollowListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_ProductFollowList_userId;
extern NSString *const kHttpParamKey_ProductFollowList_page;
extern NSString *const kHttpParamKey_ProductFollowList_size;