//
//  MySearchBar.m
//  DreamStation
//
//  Created by xjb on 2017/1/5.
//  Copyright © 2017年 QPP. All rights reserved.
//

#import "MySearchBar.h"

@implementation MySearchBar

-(instancetype)init{
    self = [super init];
    if (self) {
        //[self layoutSubviews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UITextField *textField = nil;
    textField = [[[self.subviews firstObject] subviews]lastObject];
    if ([textField isKindOfClass:[UITextField class]]) {
        textField.frame = CGRectMake(0, 3, self.bounds.size.width-5, self.bounds.size.height-8);
    }
}

-(void)setLeftPlaceholder:(NSString *)placeholder {
    self.placeholder = placeholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}
@end
