//
//  DSHttpGetPersonAccountCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/30.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpGetPersonAccountCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_GetPersonAccount_person_id;