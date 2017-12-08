//
//  DSHttpUploadFileResult.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpRequestResult.h"

@interface DSHttpUploadFileResult : SNHttpRequestResult
- (NSString *)getAvatarUrl;
- (NSString *)getSuffix;
- (NSString *)getUuid;
@end
