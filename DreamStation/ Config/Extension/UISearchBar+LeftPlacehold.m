//
//  UISearchBar+LeftPlacehold.m
//  DreamStation
//
//  Created by QPP on 16/11/30.
//  Copyright © 2016 QPP. All rights reserved.
//

#import "UISearchBar+LeftPlacehold.h"

@implementation UISearchBar (LeftPlacehold)

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    UITextField *textField = nil;
//    textField = [[[self.subviews firstObject] subviews]lastObject];
//    if ([textField isKindOfClass:[UITextField class]]) {
//        textField.frame = CGRectMake(5, 3, self.frame.size.width-5, 36);
//    }
//}
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
