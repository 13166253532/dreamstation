//
//  QSHttpBasePostCmd.h
//  QiuShi
//
//  Created by wei wu on 14-9-26.
//  Copyright (c) 2014年 wei wu. All rights reserved.
//

#import "SMHttp.h"
#import "SNHttpBaseCmd.h"

@class AFHTTPRequestOperationManager;

@interface SNHttpBasePostCmd : SNHttpBaseCmd
-(NSDictionary *)getBodyParam;
-(NSDictionary *)getRequestUrlParam;
-(AFHTTPRequestOperationManager *) afnetworkOperationManager;

@end
