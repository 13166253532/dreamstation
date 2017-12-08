//
//  UITabBar+HTBageNum.m
//  HiTeacher
//
//  Created by QPP on 16/4/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "UITabBar+HTBageNum.h"
#define TabbarItemNums 4.0    //tabbar的数量 如果是5个设置为5.0
@implementation UITabBar (HTBageNum)
- (void)showBadgeNumOnItemIndex:(int)index num:(int)num{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UILabel *badgeView = [[UILabel alloc]init];
    badgeView.textAlignment=NSTextAlignmentCenter;
    badgeView.text=[NSString stringWithFormat:@"%d",num];
    badgeView.textColor=[UIColor whiteColor];
    badgeView.font=[UIFont systemFontOfSize:11];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 6;//圆形
    badgeView.layer.masksToBounds=YES;
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 12, 12);//圆形大小为10
    [self addSubview:badgeView];

}



//隐藏小红点
- (void)hideBadgeNumOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}


//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
