//
//  XSSinaShareAlertView.h
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sinaCancelBlock)();
typedef void(^sinaSureBlock)(NSString *);



@interface XSSinaShareAlertView : UIView

@property(nonatomic,copy)sinaCancelBlock cancel_block;
@property(nonatomic,copy)sinaSureBlock sure_block;

+ (instancetype)alertViewWithCancelBtn:(sinaCancelBlock)cancelBlock withSureBtn:(sinaSureBlock)sureBlock withImageString:(NSString *)imageString withTitleString:(NSString *)titleString;

@end
