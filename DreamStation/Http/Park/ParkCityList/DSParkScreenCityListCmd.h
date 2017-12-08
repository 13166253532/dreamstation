//
//  DSParkScreenCityListCmd.h
//  DreamStation
//
//  Created by xjb on 2016/11/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSParkScreenCityListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
