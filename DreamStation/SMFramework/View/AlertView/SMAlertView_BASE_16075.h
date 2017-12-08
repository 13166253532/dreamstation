//
//  SMAlertView.h
//  BleMall
//
//  Created by K.E. on 14-11-28.
//  Copyright (c) 2014年 blemall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMAlertView : NSObject

+(void)showAlert:(NSString *)content;
+(void)showOnlyButtonAlert:(NSString*)content;
@end
