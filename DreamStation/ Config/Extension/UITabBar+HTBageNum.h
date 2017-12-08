//
//  UITabBar+HTBageNum.h
//  HiTeacher
//
//  Created by QPP on 16/4/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (HTBageNum)
- (void)showBadgeNumOnItemIndex:(int)index num:(int)num;   //显示数字

- (void)hideBadgeNumOnItemIndex:(int)index; //隐藏数字
@end
