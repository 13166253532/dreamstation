//
//  PlayerViewController.h
//  TestYKMediaPlayer
//
//  Created by weixinghua on 13-6-25.
//  Copyright (c) 2013年 Youku Inc. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface PlayerViewController : UIViewController

@property (nonatomic, assign) BOOL islocal;
@property (nonatomic, retain) id videoItem;
- (id)initWithVid:(NSString *)vid platform:(NSString *)platform quality:(NSString *)quality;

@end
