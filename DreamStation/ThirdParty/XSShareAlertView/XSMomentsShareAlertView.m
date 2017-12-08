//
//  XSMomentsShareAlertView.m
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import "XSMomentsShareAlertView.h"
#import "UIImageView+WebCache.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface XSMomentsShareAlertView()

@property(nonatomic,retain)UIView *momentAlertView;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *cancelBtn;
@property(nonatomic,retain)UIButton *sureBtn;

@end

@implementation XSMomentsShareAlertView

- (instancetype)initWithFrame:(CGRect)frame withImageString:(NSString *)imageString withTitle:(NSString *)titleString{
    self = [super initWithFrame:frame];
    if (self) {

        
        [self addSubview:self.momentAlertView];
        
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        [_imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"homePage_share"]];
        
        
        _titleLabel.text = titleString;
        
    }
    return self;
}

- (UIView *)momentAlertView{
    
    if (_momentAlertView == nil) {
        
        float alertWidth = WIDTH/6*5;
        
        _momentAlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertWidth, 100)];
        _momentAlertView.backgroundColor = [UIColor whiteColor];
        _momentAlertView.center = CGPointMake(WIDTH/2, HEIGHT/2);
        
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        [_momentAlertView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, CGRectGetMinY(_imageView.frame), alertWidth-60, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 2;
        [_momentAlertView addSubview:_titleLabel];
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame)+10, alertWidth/2, 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(momentCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_momentAlertView addSubview:_cancelBtn];
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(CGRectGetMaxX(_cancelBtn.frame), CGRectGetMinY(_cancelBtn.frame), alertWidth/2, 40);
        [_sureBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitleColor:[UIColor colorWithRed:0.000 green:0.775 blue:0.893 alpha:1.000] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(momentSureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_momentAlertView addSubview:_sureBtn];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(_cancelBtn.frame), alertWidth, 1)];
        line1.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
        [_momentAlertView addSubview:line1];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(alertWidth/2, CGRectGetMaxY(line1.frame), 1, 40)];
        line2.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
        [_momentAlertView addSubview:line2];
        
    }
    return _momentAlertView;
}

+ (instancetype)alertViewWithCancelBtn:(momentsCancelBlock)cancelBlock withSureBtn:(momentsSureBlock)surBlock withImageString:(NSString *)imageString withTitle:(NSString *)titleString{
    XSMomentsShareAlertView *momentsView = [[XSMomentsShareAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds withImageString:imageString withTitle:titleString];
    momentsView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.414];
    momentsView.cancel_block = cancelBlock;
    momentsView.sure_block = surBlock;
    return momentsView;
}

- (void)momentCancelBtnClick{
    [self removeFromSuperview];
    self.cancel_block();
}

- (void)momentSureBtnClick{
    [self removeFromSuperview];
    self.sure_block();
}

@end



















