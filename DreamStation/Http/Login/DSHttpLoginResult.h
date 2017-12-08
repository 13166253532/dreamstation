//
//  DSHttpLoginResult.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpRequestResult.h"

@interface DSHttpLoginResult : SNHttpRequestResult

- (NSString *)getAccess_token;
- (NSString *)getToken_type;
- (NSString *)getId;
- (NSString *)getRole;
- (NSString *)getLoginPhone;
- (NSString *)getisAuthorized;
- (NSString *)getisName;
- (NSString *)getisAvatar;
- (NSString *)getisParkName;
- (NSString *)getisParkNames;
- (NSString *)getInstitutionId;
- (NSString *)getInstitutionCompany;
- (NSString *)getisParkJob;
- (NSString *)getInstitutionJob;
- (NSString *)getPhone;
- (NSString *)getisParkperPhone;
//- (NSMutableArray *)getCatsArray;
@end
