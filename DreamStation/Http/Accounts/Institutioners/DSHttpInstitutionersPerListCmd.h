//
//  DSHttpInstitutionersPerListCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpInstitutionersPerListCmd : SNHttpBaseGetCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_InstitutionersPerList_institutionId;
extern NSString *const kHttpParamKey_InstitutionersPerList_page;
extern NSString *const kHttpParamKey_InstitutionersPerList_size;