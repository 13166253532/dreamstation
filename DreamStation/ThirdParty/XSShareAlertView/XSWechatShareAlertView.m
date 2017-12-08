//
//  XSWechatShareAlertView.m
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import "XSWechatShareAlertView.h"

#import "UIImageView+WebCache.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface XSWechatShareAlertView()<UITextFieldDelegate>

@property(nonatomic,retain)UIView *wechatAlertView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *contentLabel;
@property(nonatomic,retain)UILabel *markLabel;
@property(nonatomic,retain)UITextField *textField;
@property(nonatomic,retain)UIButton *cancelBtn;
@property(nonatomic,retain)UIButton *sureBtn;
@property(nonatomic,copy)NSString *textValue;

@end

@implementation XSWechatShareAlertView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)titleString withTitleImage:(NSString *)imageString withContent:(NSString *)ContentString{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.wechatAlertView];
        
        _titleLabel.text = titleString;
        _contentLabel.text = ContentString;
        
        NSURL *imageUrl = [NSURL URLWithString:imageString];
      
        [_imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"homePage_share"]];
        
        
//        UIWindow *currentWindows = [UIApplication sharedApplication].keyWindow;
//        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
//        [currentWindows addSubview:self];
//        [self.window addSubview:self];
        
    }
    return self;
}

- (UIView *)wechatAlertView{
    if (_wechatAlertView == nil) {
        
        float alertWidth = WIDTH/6*5;
        
        _wechatAlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertWidth,235)];
        _wechatAlertView.backgroundColor = [UIColor whiteColor];
        _wechatAlertView.center = CGPointMake(WIDTH/2, HEIGHT/2);
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, alertWidth-20, 40)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [_wechatAlertView addSubview:_titleLabel];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+5, 60, 60)];
        [_wechatAlertView addSubview:_imageView];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, CGRectGetMinY(_imageView.frame), alertWidth-80, 60)];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [_wechatAlertView addSubview:_contentLabel];
        
        _markLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageView.frame)+5, 100, 30)];
        _markLabel.text = @"来自极客出发";
        _markLabel.font = [UIFont systemFontOfSize:12];
        [_wechatAlertView addSubview:_markLabel];
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_markLabel.frame)+5, alertWidth-20, 35)];
        _textField.delegate = self;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.layer.borderWidth = 1;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"  给朋友留言";
        _textField.font = [UIFont systemFontOfSize:15];
        [_wechatAlertView addSubview:_textField];
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(_textField.frame)+10,alertWidth/2 , 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(wechatCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_wechatAlertView addSubview:_cancelBtn];
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(CGRectGetMaxX(_cancelBtn.frame), CGRectGetMinY(_cancelBtn.frame), alertWidth/2, 40);
        [_sureBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitleColor:[UIColor colorWithRed:0.000 green:0.775 blue:0.893 alpha:1.000] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(wechatsureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_wechatAlertView addSubview:_sureBtn];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(_cancelBtn.frame), alertWidth, 1)];
        line1.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
        [_wechatAlertView addSubview:line1];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(alertWidth/2, CGRectGetMaxY(line1.frame), 1, 40)];
        line2.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
        [_wechatAlertView addSubview:line2];
        
    }
    
    return _wechatAlertView;
}


+ (instancetype)alertViewWithCancelBtn:(wechatCancelBlock)cancelBlock withSureBtn:(wechatSureBlock)sureBlock withTitle:(NSString *)titleString withTitleImage:(NSString *)imageString withContent:(NSString *)ContentString{
    XSWechatShareAlertView *wechatView = [[XSWechatShareAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds withTitle:titleString withTitleImage:imageString withContent:ContentString];
    wechatView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.414];
    wechatView.cancel_block = cancelBlock;
    wechatView.sure_block = sureBlock;
    return wechatView;
}

- (void)wechatCancelBtnClick{
    [self removeFromSuperview];
    self.cancel_block();
}

- (void)wechatsureBtnClick{
    [self removeFromSuperview];
    self.sure_block(self.textValue);
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    self.textValue = textField.text;
}

@end
