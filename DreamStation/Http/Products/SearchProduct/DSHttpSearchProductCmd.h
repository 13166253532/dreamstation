//
//  DSHttpSearchProductCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/6.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpSearchProductCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_SearchProduct_page;
extern NSString *const kHttpParamKey_SearchProduct_size;
extern NSString *const kHttpParamKey_SearchProduct_name;