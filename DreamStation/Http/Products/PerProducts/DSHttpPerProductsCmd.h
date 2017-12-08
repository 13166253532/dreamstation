//
//  DSHttpPerProductsCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpPerProductsCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_PerProducts_id;