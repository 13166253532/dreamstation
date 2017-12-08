//
//  SNPhotoBrowserTool.h
//  soccernotes
//
//  Created by sqb on 15/9/14.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol SNImageModel;

@class DTPTagsInfo;
@interface SNPhotoBrowserTool : NSObject
//+(SNPhotoBrowserTool*)showPhotoBrowser:(NSInteger)index originData:(NSArray<SNImageModel>*)originArray containerView:(UIView*)containerView;
+(SNPhotoBrowserTool*)showPhotoBrowser:(NSInteger)index originData:(NSArray*)originArray containerVC:(UIViewController*)containerVC;

@end
