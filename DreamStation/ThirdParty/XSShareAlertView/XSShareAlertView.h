//
//  XSShareAlertView.h
//  customView
//
//  Created by 刘佳斌 on 16/10/8.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import <UIKit/UIKit.h>

//取消按钮点击事件
typedef void(^cancelBlock)();

typedef void(^sinaBlock)();
typedef void(^wechatBlock)();
typedef void(^momentsBlock)();

@interface XSShareAlertView : UIView

@property(nonatomic,copy)cancelBlock cancel_block;
@property(nonatomic,copy)sinaBlock sina_block;
@property(nonatomic,copy)wechatBlock wechat_block;
@property(nonatomic,copy)momentsBlock moments_block;

+ (instancetype)alertViewWithCancelBtn:(cancelBlock)cancelBlock withSinaBtn:(sinaBlock)sinaBlock withWechatBtn:(wechatBlock)wechatBlock withMomentsBtn:(momentsBlock)momentsBlock;

+ (instancetype)alertViewWithCancelBtn:(cancelBlock)cancelBlock withWechatBtn:(wechatBlock)wechatBlock withMomentsBtn:(momentsBlock)momentsBlock;

@end
