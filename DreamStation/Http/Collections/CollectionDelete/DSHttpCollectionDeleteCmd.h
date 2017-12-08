//
//  DSHttpCollectionDeleteCmd.h
//  DreamStation
//
//  Created by QPP on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBaseDeleteCmd.h"

@interface DSHttpCollectionDeleteCmd : SNHttpBaseDeleteCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_Collection_collectionId;