//
//  DSSegmentedDic.h
//  DreamStation
//
//  Created by xjb on 2017/1/3.
//  Copyright © 2017年 QPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DSSegmentedDic : NSObject
+ (NSDictionary *)getSelectedDic:(UIColor *)color;
+ (NSDictionary *)getNormalDic:(UIColor *)color;
@end
