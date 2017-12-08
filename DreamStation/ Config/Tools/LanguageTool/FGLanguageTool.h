//
//  FGLanguageTool.h
//  HiTeacher
//
//  Created by QPP on 16/4/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGLanguageTool : NSObject

+(id)sharedInstance;
/**
*  返回table中指定的key的值
*
*  @param key   key
*  @param table table
*
*  @return 返回table中指定的key的值
*/

-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;
/**
*  改变当前语言
*/

-(void)changeNowLanguage;
/**
*  设置新的语言
*
*  @param language 新语言
*/

-(void)setNewLanguage:(NSString*)language;


@end
