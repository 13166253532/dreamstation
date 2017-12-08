//
//  QSHttpBaseCommand.h
//  QiuShi
//
//  Created by wei wu on 14-9-26.
//  Copyright (c) 2014年 wei wu. All rights reserved.
//

#import "SMHttp.h"

#import "HTHttpConfig.h"
#import "PVHttpVersion.h"

extern const NSString *kResult;


@interface SNHttpBaseCmd : HttpCommand

-(instancetype)initWithVersion:(NSString *)version;
//-(BOOL)checkLoginIsValid;
-(HttpConfig *)httpConfig;
-(NSString *)serverAddressKey;
-(void)onRequestFailed:(NSError *)error;


-(NSString*)DataTOjsonString:(id)object;
-(NSString *)getAuthorization;
-(void)showHintView:(NSString*)content;
-(void)hidenHintView;
-(void)judgeTokenExpired:(NSInteger)code;

@end
