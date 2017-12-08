//
//  XSMomentsShareAlertView.h
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^momentsCancelBlock)();
typedef void(^momentsSureBlock)();

@interface XSMomentsShareAlertView : UIView

@property(nonatomic,copy)momentsCancelBlock cancel_block;
@property(nonatomic,copy)momentsSureBlock sure_block;

+ (instancetype)alertViewWithCancelBtn:(momentsCancelBlock)cancelBlock withSureBtn:(momentsSureBlock)surBlock withImageString:(NSString *)imageString withTitle:(NSString *)titleString;

@end
