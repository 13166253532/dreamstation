//
//  shareBtn.m
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import "shareBtn.h"

@implementation shareBtn

- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)imageString withTitle:(NSString *)title{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-150)/2, 15, 20, 20)];
        imageView.image = [UIImage imageNamed:imageString];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 10, 130, 30)];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
        [self addSubview:titleLabel];
        
    }
    return self;
}

@end
