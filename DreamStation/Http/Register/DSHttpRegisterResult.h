//
//  DSHttpRegisterResult.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpRequestResult.h"

@interface DSHttpRegisterResult : SNHttpRequestResult


- (NSString *)getAccessToken;
- (NSString *)getId;
- (NSString *)getAvatar;
- (NSString *)getName;
- (NSString *)getRole;
- (NSString *)getIsAuthorized;
- (NSString *)getPhone;

@end
