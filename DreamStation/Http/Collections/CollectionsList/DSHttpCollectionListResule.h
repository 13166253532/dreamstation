//
//  DSHttpCollectionListResule.h
//  DreamStation
//
//  Created by xjb on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpRequestResult.h"

@interface DSHttpCollectionListResule : SNHttpRequestResult
- (NSMutableArray *)getTheContent;
- (NSString *)getThesize;
@end
