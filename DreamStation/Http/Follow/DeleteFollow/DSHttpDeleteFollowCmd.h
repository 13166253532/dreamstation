//
//  DSHttpDeleteFollowCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseDeleteCmd.h"

@interface DSHttpDeleteFollowCmd : SNHttpBaseDeleteCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_DeleteFollow_id;
extern NSString *const kHttpParamKey_DeleteFollow_itemId;