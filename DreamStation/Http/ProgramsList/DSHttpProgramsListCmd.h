//
//  DSHttpProgramsListCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpProgramsListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end


extern NSString *const kHttpParamKey_ProgramsList_page;
extern NSString *const kHttpParamKey_ProgramsList_size;
extern NSString *const kHttpParamKey_ProgramsList_type;
extern NSString *const kHttpParamKey_ProgramsList_showOnlyPublish;