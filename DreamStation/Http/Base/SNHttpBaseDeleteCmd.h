//
//  SNHttpBaseDeleteCmd.h
//  DreamStation
//
//  Created by QPP on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//
#import "SMHttp.h"
#import "SNHttpBaseCmd.h"
@class AFHTTPRequestOperationManager;

@interface SNHttpBaseDeleteCmd : SNHttpBaseCmd
-(AFHTTPRequestOperationManager *) afnetworkOperationManager;
@end
