//
//  DTPHttpBasePutCmd.h
//  DTPocket
//
//  Created by sqb on 15/4/1.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import "SNHttpBaseCmd.h"

@class AFHTTPRequestOperationManager;
@interface SNHttpBasePutFileCmd : SNHttpBaseCmd
-(AFHTTPRequestOperationManager *) afnetworkOperationManager;

@property NSString *keyName;
@property NSString *fileName;
@property NSString *filePath;
@property NSData *fileData;

@end
