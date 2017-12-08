//
//  XWAlterview.m
//  new
//
//  Created by chinat2t on 14-11-6.
//  Copyright (c) 2014年 chinat2t. All rights reserved.
//

#import "XWAlterview.h"
// 设置警告框的长和宽

#define Alertwidth 220.0f
#define Alertheigth 180.0f
#define XWtitleofheigth 25.0f

@interface XWAlterview ()

@property (nonatomic,assign)CGFloat alertHeight;
@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIView *backimageView;
@end

@implementation XWAlterview

+(XWAlterview*)showmessage:(NSString *)message subtitle:(NSString *)subtitle
{

    XWAlterview *alert = [[XWAlterview alloc] initWithTitle:message contentText:subtitle];
//    [alert show];
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"cancel button clicked");
    };
    return alert;
}

- (id)initWithTitle:(NSString *)title contentText:(NSString *)content
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1;
        
        if (content.length>100) {
            self.alertHeight = 220;
        }else{
            self.alertHeight = 100;
        }
        
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, Alertwidth, XWtitleofheigth)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        self.alertTitleLabel.textColor=[UIColor blackColor];
        [self addSubview:self.alertTitleLabel];
        
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, Alertwidth-10, self.alertHeight-30)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textColor = [UIColor blackColor];
        self.alertContentLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:self.alertContentLabel];
        //        设置对齐方式
        self.alertContentLabel.textAlignment = NSTextAlignmentLeft;

        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [xButton setImage:[UIImage imageNamed:@"btn_close_normal.png"] forState:UIControlStateNormal];
        xButton.frame = CGRectMake(Alertwidth - 30, 5, 25, 25);
        [self addSubview:xButton];
        [xButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self show];
    }
    return self;
}

- (void)show
{   //获取第一响应视图视图
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5-30, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5-20, Alertwidth, self.alertHeight);
    self.alpha=0;
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{

    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    [self.backimageView removeFromSuperview];
    self.backimageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5+30, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5-30, Alertwidth, self.alertHeight);
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.alpha=0;
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];

}
//添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息）
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    //     获取根控制器
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backimageView) {
        self.backimageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backimageView.backgroundColor = [UIColor colorWithWhite:0.845 alpha:0.186];
        self.backimageView.alpha = 1.0f;
        self.backimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    //    加载背景背景图,防止重复点击
    [topVC.view addSubview:self.backimageView];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5, Alertwidth, self.alertHeight);
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = afterFrame;
        self.alpha=1.0;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
