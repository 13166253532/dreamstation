//
//  ZYTokenManager.m
//  自定义搜索框并缓存搜索记录
//
//  Created by xiayong on 16/3/11.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "ZYTokenManager.h"

@interface ZYTokenManager()

@end

@implementation ZYTokenManager

//缓存搜索数组
+(void)SearchText :(NSString *)seaTxt withKey:(NSString *)key
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:key];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组
        
    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    
    BOOL isAdd = false;
    
    NSMutableArray *searTXT = [myArray mutableCopy];
    //清除相同的历史记录
    for (NSString *string in searTXT) {
        if ([string isEqualToString:seaTxt]) {
            isAdd = YES;
        }
    }
    
    if (isAdd != YES) {
        [searTXT addObject:seaTxt];
    }else{
        [searTXT removeObject:seaTxt];
        [searTXT addObject:seaTxt];
    }
    
    if(searTXT.count > 5)
    {
        [searTXT removeObjectAtIndex:0];
    }
    
    //将上述数据全部存储到NSUserDefaults中
    [userDefaultes setObject:searTXT forKey:key];
    [userDefaultes synchronize];
}

+(void)removeAllArray:(NSString *)key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
