//
//  DSHttpDetailActivityCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpDetailActivityCmd : SNHttpBaseGetCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;

@end

extern NSString *const kHttpParamKey_DetailActivity_id;