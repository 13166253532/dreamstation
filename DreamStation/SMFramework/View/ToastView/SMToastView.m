//
//  BMToastView.m
//  BleMall
//
//  Created by wei wu on 14/11/24.
//  Copyright (c) 2014年 blemall. All rights reserved.
//

#import "SMToastView.h"
#import "UIView+Toast.h"

@interface SMToastView()
@end

@implementation SMToastView
//+ (UIView *)sharedView {
//    static dispatch_once_t once;
//    static UIView *sharedView;
//    dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
//    return sharedView;
//}

+(void)showMessage:(UIView *)parentView withMessage:(NSString *)msg
{
    [parentView makeToast:msg];
}

+(void)showMessageCenter:(UIView *)parentView withMessage:(NSString *)msg
{
    [parentView makeToast:msg duration:2 position:CSToastPositionCenter];
}

@end
