//
//  QSHttpBaseGetCmd.h
//  QiuShi
//
//  Created by wei wu on 14-9-26.
//  Copyright (c) 2014年 wei wu. All rights reserved.
//

#import "SMHttp.h"
#import "SNHttpBaseCmd.h"

extern  NSString *const kHttpParamKey_pageNum ;
extern  NSString *const kHttpParamKey_pageSize ;
extern NSString *const kHttpParamKey_address ;

@class AFHTTPRequestOperationManager;

@interface SNHttpBaseGetCmd : SNHttpBaseCmd
-(AFHTTPRequestOperationManager *) afnetworkOperationManager;
@end
