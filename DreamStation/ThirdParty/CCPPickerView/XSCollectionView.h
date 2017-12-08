//
//  XSCollectionView.h
//  CCPPickerDemo
//
//  Created by 刘佳斌 on 16/8/4.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cancelOfClick)();
typedef void (^sureOfClick)(NSArray *chooseDataList);

@interface XSCollectionView : UIView

@property (copy,nonatomic) void(^cancelOfClick)();
@property (copy,nonatomic) void(^sureOfClick)(NSArray *chooseDataList);

- (instancetype)initWithCollectionViewWithCenterTitle:(NSString *)title andCancel:(NSString *)cancel andSure:(NSString *)sure andData:(NSArray *)data andType:(int)type;

- (void)collectionViewClickCancelBtnBlock:(cancelOfClick)cancelBlock sureBtnClick:(sureOfClick)sureBlock;

- (instancetype)initWithCollectionViewWithCenterTitle:(NSString *)title andCancel:(NSString *)cancel andSure:(NSString *)sure andData:(NSArray *)data andType:(int)type andSelectedList:(NSArray *)selectedList;

@end
