//
//  MDFStringHandle.m
//  MDF
//
//  Created by K.E. on 16/9/18.
//  Copyright © 2016年 smilingmobile. All rights reserved.
//

#import "MDFStringHandle.h"

@implementation MDFStringHandle

+(NSString *)stringTakeOutSpecialCharacter:(NSString *)str
{
    for (int i = 0; i<[str length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"string is %@",s);
        if ([s isEqualToString:@"["]||[s isEqualToString:@"]"]) {
            NSRange range = NSMakeRange(i, 1);
            //将字符串中的“@”转化为“_”
            str =   [str stringByReplacingCharactersInRange:range withString:@""];
            
        }
    }
    return str;
}
@end
