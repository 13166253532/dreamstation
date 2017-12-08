//
//  QSHttpRequestResult.h
//  QiuShi
//
//  Created by wei wu on 14-9-26.
//  Copyright (c) 2014年 wei wu. All rights reserved.
//

#import "RequestResult.h"

@interface SNHttpRequestResult : RequestResult
-(BOOL)parseBasicInfo:(NSDictionary *)response code:(NSInteger)code;

@end
