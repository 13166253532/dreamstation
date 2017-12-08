//
//  DSSegmentedDic.m
//  DreamStation
//
//  Created by xjb on 2017/1/3.
//  Copyright © 2017年 QPP. All rights reserved.
//

#import "DSSegmentedDic.h"
#import <UIKit/UIKit.h>
@implementation DSSegmentedDic
+ (NSDictionary *)getSelectedDic:(UIColor *)color{
    
    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    return selected;
}

+ (NSDictionary *)getNormalDic:(UIColor *)color{
    
    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    return selected;
}
@end
