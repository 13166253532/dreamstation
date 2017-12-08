//
//  UITabBar+HTBage.m
//  HiTeacher
//
//  Created by QPP on 16/4/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "UITabBar+HTBage.h"
 #define TabbarItemNums 4.0    //tabbar的数量

@implementation UITabBar (HTBage)

- (void)showBadgeOnItemIndex:(int)index{ //移除之前的小红点
    [self removeBadgeOnItemIndex:index]; //新建小红点
    UIImageView *badgeView = [[UIImageView alloc]init];
    badgeView.image=[UIImage imageNamed:@"tabBar_RedPoint_small"];
    badgeView.contentMode=UIViewContentModeScaleAspectFit;
    CGRect tabFrame = self.frame; //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 5, 5);
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(int)index{ //移除小红点
    [self removeBadgeOnItemIndex:index];
}
- (void)removeBadgeOnItemIndex:(int)index{ //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
