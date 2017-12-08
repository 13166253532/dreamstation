//
//  UITabBar+HTBage.h
//  HiTeacher
//
//  Created by QPP on 16/4/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (HTBage)
- (void)showBadgeOnItemIndex:(int)index; //显示小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
