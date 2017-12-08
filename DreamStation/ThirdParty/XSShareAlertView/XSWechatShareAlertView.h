//
//  XSWechatShareAlertView.h
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^wechatCancelBlock)();
typedef void(^wechatSureBlock)(NSString *);


@interface XSWechatShareAlertView : UIView

@property(nonatomic,copy)wechatCancelBlock cancel_block;
@property(nonatomic,copy)wechatSureBlock sure_block;


+ (instancetype)alertViewWithCancelBtn:(wechatCancelBlock)cancelBlock withSureBtn:(wechatSureBlock)sureBlock withTitle:(NSString *)titleString withTitleImage:(NSString *)imageString withContent:(NSString *)ContentString;
@end
