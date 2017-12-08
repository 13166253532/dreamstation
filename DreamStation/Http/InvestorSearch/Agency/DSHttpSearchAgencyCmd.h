//
//  DSHttpSearchAgencyCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/7.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpSearchAgencyCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_SearchAgency_page;
extern NSString *const kHttpParamKey_SearchAgency_size;
extern NSString *const kHttpParamKey_SearchAgency_name;