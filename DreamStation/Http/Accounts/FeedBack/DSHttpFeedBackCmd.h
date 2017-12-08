//
//  DSHttpFeedBackCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/29.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpFeedBackCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end

extern NSString *const kHttpParamKey_FeedBack_fromId;
extern NSString *const kHttpParamKey_FeedBack_fromName;
extern NSString *const kHttpParamKey_FeedBack_message;