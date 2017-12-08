//
//  MDFStringHandle.h
//  MDF
//
//  Created by K.E. on 16/9/18.
//  Copyright © 2016年 smilingmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDFStringHandle : NSObject
+(NSString *)stringTakeOutSpecialCharacter:(NSString *)str;
@end
