//
//  XSShareAlertView.m
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import "XSShareAlertView.h"
#import "shareBtn.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface XSShareAlertView()

@property(nonatomic,retain)UIView *alertView;
@property(nonatomic,retain)UIView *alertView2;
@property(nonatomic,retain)shareBtn *sinaBtn;
@property(nonatomic,retain)shareBtn *wechatBtn;
@property(nonatomic,retain)shareBtn *momentsBtn;
@property(nonatomic,retain)UIButton *cancelBtn;
@property(nonatomic,assign)float viewHeight;

@end

@implementation XSShareAlertView


- (instancetype)initWithFrame:(CGRect)frame withSina:(BOOL)isHave{

    self = [super initWithFrame:frame];
    if (self) {
        
        if (isHave == YES) {
            self.viewHeight = 0;
            [self addSubview:self.alertView];
        }else{
            self.viewHeight = 50;
            [self addSubview:self.alertView2];
        }

    }
    return self;
}

- (UIView *)alertView{
    
    if (_alertView == nil) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-210, WIDTH, 210)];
        _alertView.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
        
        [_alertView addSubview:[self addSinaView]];
        [_alertView addSubview:[self addWechatView]];
        [_alertView addSubview:[self addMomentsView]];
        [_alertView addSubview:[self addCancelView]];
        
        //分割线
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WIDTH, 1)];
        line1.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
        [_alertView addSubview:line1];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 1)];
        line2.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
        [_alertView addSubview:line2];

    }
    return _alertView;
}

- (UIView *)alertView2{
    if (_alertView2 == nil) {
        _alertView2 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-160, WIDTH, 160)];
        _alertView2.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
        
        [_alertView2 addSubview:[self addWechatView]];
        [_alertView2 addSubview:[self addMomentsView]];
        [_alertView2 addSubview:[self addCancelView]];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WIDTH, 1)];
        line1.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
        [_alertView2 addSubview:line1];
    }
    return _alertView2;
}

//新浪
- (shareBtn *)addSinaView{
    
    _sinaBtn = [[shareBtn alloc]initWithFrame:CGRectMake(0, 0-self.viewHeight, WIDTH, 50) withImage:@"homePage_weibo" withTitle:@"分享到新浪微博"];
    _sinaBtn.backgroundColor = [UIColor whiteColor];
    [_sinaBtn addTarget:self action:@selector(sinaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return _sinaBtn;
}
//微信
- (shareBtn *)addWechatView{
    
    _wechatBtn = [[shareBtn alloc]initWithFrame:CGRectMake(0, 50-self.viewHeight, WIDTH, 50) withImage:@"homePage_wechat" withTitle:@"分享给微信好友"];
    _wechatBtn.backgroundColor = [UIColor whiteColor];
    [_wechatBtn addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return _wechatBtn;
}
//朋友圈
- (shareBtn *)addMomentsView{
    _momentsBtn = [[shareBtn alloc]initWithFrame:CGRectMake(0, 100-self.viewHeight, WIDTH, 50) withImage:@"homePage_moments" withTitle:@"分享到朋友圈"];
    _momentsBtn.backgroundColor = [UIColor whiteColor];
    [_momentsBtn addTarget:self action:@selector(momentsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return _momentsBtn;
}
//取消按钮
- (UIButton *)addCancelView{
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, 160-self.viewHeight, WIDTH, 50);
    _cancelBtn.backgroundColor = [UIColor whiteColor];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithWhite:0.400 alpha:1.000] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return _cancelBtn;
}

#pragma mark ---包含新浪微博
+ (instancetype)alertViewWithCancelBtn:(cancelBlock)cancelBlock withSinaBtn:(sinaBlock)sinaBlock withWechatBtn:(wechatBlock)wechatBlock withMomentsBtn:(momentsBlock)momentsBlock{
    
    XSShareAlertView *alertView = [[XSShareAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds withSina:YES];
    alertView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.414];
    alertView.cancel_block = cancelBlock;
    alertView.sina_block = sinaBlock;
    alertView.wechat_block = wechatBlock;
    alertView.moments_block = momentsBlock;
    return alertView;
}

#pragma mark ---不包括新浪微博
+ (instancetype)alertViewWithCancelBtn:(cancelBlock)cancelBlock withWechatBtn:(wechatBlock)wechatBlock withMomentsBtn:(momentsBlock)momentsBlock{
    
    XSShareAlertView *alertView = [[XSShareAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds withSina:NO];
    alertView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.414];
    alertView.cancel_block = cancelBlock;
    alertView.wechat_block = wechatBlock;
    alertView.moments_block = momentsBlock;
    return alertView;
}

- (void)dissMissView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alertView.frame = CGRectMake(0, HEIGHT, WIDTH, 210);
        self.alertView2.frame = CGRectMake(0, HEIGHT, WIDTH, 210);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)cancelBtnClick
{
    [self dissMissView];
    self.cancel_block();
}

- (void)sinaBtnClick{
    self.sina_block();
    [self removeFromSuperview];
    
}

- (void)wechatBtnClick{
    self.wechat_block();
    [self removeFromSuperview];
    
}

- (void)momentsBtnClick{
    self.moments_block();
    [self removeFromSuperview];
    
}

@end




























