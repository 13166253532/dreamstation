//
//  UITextField+HTPlaceholderColor.m
//  HiTeacher
//
//  Created by QPP on 16/4/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "UITextField+HTPlaceholderColor.h"

@implementation UITextField (HTPlaceholderColor)
-(void)setPlaceholderColor:(UIColor *)color
{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}
@end
