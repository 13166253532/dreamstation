//
//  SMBaseViewControllerMediator.m
//  QiuShi
//
//  Created by wei wu on 14-9-30.
//  Copyright (c) 2014年 blemall. All rights reserved.
//

#import "SMBaseViewControllerMediator.h"
#import "DreamStation-Swift.h"

//#import "FGBaseViewController.h"

@interface SMBaseViewControllerMediatorItem()
{
   UIViewController *_destViewController;
}
@property (copy) UIViewController * (^creatorBlock)(id);

@end

@implementation SMBaseViewControllerMediatorItem
@synthesize destViewController;

-(id)initWithBlock:(UIViewController * (^)(id))block
{
    self = [super init];
    if (nil != self)
    {
        NSAssert(nil != block,@"Must define block");
        _creatorBlock = block;
    }
    return self;
}
-(void)setDestViewController:(UIViewController *)vc
{
    _destViewController = vc;
}
-(UIViewController *)destViewController
{
   HTBaseViewController *vc = (HTBaseViewController *)_creatorBlock(_arg);
   vc.createArgs = self.arg;
   return vc;
}
@end

@interface SMBaseViewControllerMediator()
{
    NSMutableDictionary *_itemDic;
}
@end

@implementation SMBaseViewControllerMediator
-(id)init{
    self = [super init];
    if (nil != self) {
        _itemDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)addItem:(NSString *)identifer item:(SMBaseViewControllerMediatorItem *)item
{
    NSAssert(nil != _itemDic,nil);
    [_itemDic setObject:item forKey:identifer];
}
-(void)removeItem:(NSString *)identifer{
    [_itemDic removeObjectForKey:identifer];
}
-(SMBaseViewControllerMediatorItem *)item:(NSString *)identifier
{
    return [_itemDic objectForKey:identifier];
}
-(void)gotoViewController:(UIViewController *)srcViewController
                           identifier:(NSString *)identifier
                           argument:(id)argument
                           animated:(BOOL)animated
{
    SMBaseViewControllerMediatorItem *item = [self item:identifier];
    item.arg = argument;
    NSAssert(nil != item, @"Cannot find item for key %@",identifier);

    HTBaseViewController *src = (HTBaseViewController *)srcViewController;
    
    NSAssert([src respondsToSelector:@selector(pushViewController:animated:)],@"Must have selector pushViewController");
    [src pushViewController:item.destViewController animated:animated];
}

@end
