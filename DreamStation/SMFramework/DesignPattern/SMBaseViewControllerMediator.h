//
//  SMBaseViewControllerMediator.h
//  SMFramework
//
//  Created by wei wu on 14-9-30.
//  Copyright (c) 2014年 blemall. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;

@interface SMBaseViewControllerMediatorItem :NSObject
-(id)initWithBlock:(UIViewController * (^)(id))block;
@property UIViewController *destViewController;
@property id arg;
@end

@interface SMBaseViewControllerMediator : NSObject
-(void)addItem:(NSString *)identifer item:(SMBaseViewControllerMediatorItem *)item;
-(void)removeItem:(NSString *)identifer;
-(SMBaseViewControllerMediatorItem *)item:(NSString *)identifier;
-(void)gotoViewController:(UIViewController *)srcViewController identifier:(NSString *)identifier argument:(id)argument animated:(BOOL)animated;
@end
