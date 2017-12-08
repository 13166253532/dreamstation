//
//  SMAlertView.m
//  BleMall
//
//  Created by K.E. on 14-11-28.
//  Copyright (c) 2014年 blemall. All rights reserved.
//

#import "SMAlertView.h"

@implementation SMAlertView


+(void)sshowAlert:(NSString*)content{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}



+(void)showOnlyButtonAlert:(NSString*)content title:(NSString *)title{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    [alertView show];
}
+(void)showAlert:(NSString*)content{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    
}

+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:content delegate:self cancelButtonTitle:title otherButtonTitles: nil];
    [alertView show];
    
}

+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:content delegate:self cancelButtonTitle:title otherButtonTitles: nil];
    alertView.delegate = delegate;
    [alertView show];
}

+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    [alertView show];
}

//+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate
//{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
//    alertView.delegate = delegate;
//    [alertView show];
//}

+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate viewTag:(NSInteger)viewTag
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    alertView.tag = viewTag;
    [alertView show];
}

+(void)showAlertWithInputNumView:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *tf = [alertView textFieldAtIndex:0];
    tf.placeholder = @"请输入";
    //tf.keyboardType = UIKeyboardTypeNumberPad;
    [alertView show];
}
@end
