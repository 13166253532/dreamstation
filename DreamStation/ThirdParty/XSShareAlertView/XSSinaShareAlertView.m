//
//  XSSinaShareAlertView.m
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import "XSSinaShareAlertView.h"
#import "BRPlaceholderTextView.h"
#import "UIImageView+WebCache.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface XSSinaShareAlertView()<UITextViewDelegate>

@property(nonatomic,retain)UIView *sinaAlertView;
@property(nonatomic,retain)BRPlaceholderTextView *textView;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UIButton *cancelBtn;
@property(nonatomic,retain)UIButton *sureBtn;
@property(nonatomic,copy)NSString *textValue;

@end

@implementation XSSinaShareAlertView

- (instancetype)initWithFrame:(CGRect)frame withImageString:(NSString *)imageString withTitleString:(NSString *)titleString{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.sinaAlertView];
        
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        
        [_imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"homePage_share"]];
        
        _label.text = titleString;
        
        UIWindow *currentWindows = [UIApplication sharedApplication].keyWindow;
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.414];
        [currentWindows addSubview:self];
    }
    return self;
}

- (UIView *)sinaAlertView{
    if (_sinaAlertView == nil) {
        
        float alertWidth = WIDTH/6*5;
        
        _sinaAlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertWidth, 210)];
        _sinaAlertView.backgroundColor = [UIColor whiteColor];
        _sinaAlertView.center = CGPointMake(WIDTH/2, HEIGHT/2);
        
        _textView = [[BRPlaceholderTextView alloc]initWithFrame:CGRectMake(5, 5, alertWidth-10, 100)];
        _textView.placeholder = @"说点什么吧...";
        _textView.delegate = self;
        [_sinaAlertView addSubview:_textView];
        
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_textView.frame)+5, alertWidth-10, 50)];
        titleView.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        
        [titleView addSubview:_imageView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, CGRectGetMinY(_imageView.frame)-5, CGRectGetWidth(titleView.frame)-60, 40)];
        _label.font = [UIFont systemFontOfSize:15];
        _label.numberOfLines = 2;
        [titleView addSubview:_label];
        
        [_sinaAlertView addSubview:titleView];
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(titleView.frame)+10, alertWidth/2, 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sinaAlertView addSubview:_cancelBtn];
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(CGRectGetMaxX(_cancelBtn.frame), CGRectGetMinY(_cancelBtn.frame), CGRectGetWidth(_cancelBtn.frame), 40);
        [_sureBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitleColor:[UIColor colorWithRed:0.000 green:0.775 blue:0.893 alpha:1.000] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_sinaAlertView addSubview:_sureBtn];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(_cancelBtn.frame), alertWidth, 1)];
        line1.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
        [_sinaAlertView addSubview: line1];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(alertWidth/2, CGRectGetMinY(_sureBtn.frame), 0.5, CGRectGetHeight(_cancelBtn.frame))];
        line2.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
        [_sinaAlertView addSubview:line2];
        
    }
    return _sinaAlertView;
}

+ (instancetype)alertViewWithCancelBtn:(sinaCancelBlock)cancelBlock withSureBtn:(sinaSureBlock)sureBlock withImageString:(NSString *)imageString withTitleString:(NSString *)titleString{
    XSSinaShareAlertView *sinaView = [[XSSinaShareAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds withImageString:imageString withTitleString:titleString];
    sinaView.cancel_block = cancelBlock;
    sinaView.sure_block = sureBlock;
    return sinaView;
}

- (void)cancelBtnClick{
    [self removeFromSuperview];
    self.cancel_block();
}

- (void)sureBtnClick{
    [self removeFromSuperview];
    self.sure_block(self.textValue);
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"%@",textView.text);
    self.textValue = textView.text;
}


@end











