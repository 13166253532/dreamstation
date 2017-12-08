//
//  DSHttpActivitySignupResult.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpRequestResult.h"
@class DSBaseActivityInfo;
@interface DSHttpActivitySignupResult : SNHttpRequestResult
- (DSBaseActivityInfo *)getResult;
@end
