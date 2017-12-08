//
//  DSHttpChangeMarkCmd.h
//  DreamStation
//
//  Created by xjb on 2016/12/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePutCmd.h"

@interface DSHttpChangeMarkCmd : SNHttpBasePutCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_ChangeMark_id;
extern NSString *const kHttpParamKey_ChangeMark_mark;
