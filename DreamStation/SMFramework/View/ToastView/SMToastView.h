//
//  BMToastView.h
//  BleMall
//
//  Created by wei wu on 14/11/24.
//  Copyright (c) 2014年 blemall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMToastView : UIView
+(void)showMessage:(UIView *)parentView withMessage:(NSString *)msg;
+(void)showMessageCenter:(UIView *)parentView withMessage:(NSString *)msg;
@end
