//
//  HTShareSDKTool.h
//  HiTeacher
//
//  Created by QPP on 16/6/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HTShareSDKTool : NSObject

+ (HTShareSDKTool *)sharedShareSDKTool;

- (void)registerApp;

- (void)shareForPlat:(NSString *)url;
- (void)shareForPlat:(NSString *)url withImage:(NSString *)image withTitle:(NSString *)title;
- (void)shareForPlatOnWechat:(NSString *)url withImage:(NSString *)image withTitle:(NSString *)title;

//微博
- (void)shareForSina:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)pageUrl;
- (void)shareForPlat:(NSString *)url withImage:(NSString *)image withTitle:(NSString *)title;
//微信
- (void)shareForWechat:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)pageUrl withContent:(NSString *)contentValue;
- (void)shareForWechat:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)pageUrl;
//朋友圈
- (void)shareForMoments:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)pageUrl;
@end
