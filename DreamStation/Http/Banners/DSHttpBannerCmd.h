//
//  DSHttpBannerCmd.h
//  DreamStation
//
//  Created by QPP on 16/8/4.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpBannerCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
