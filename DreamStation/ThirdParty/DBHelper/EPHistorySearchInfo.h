//
//  EPHistorySearchInfo.h
//  electricVCP
//
//  Created by QPP on 16/3/31.
//  Copyright © 2016年 qbshen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
@interface EPHistorySearchInfo : NSObject
@property (copy, nonatomic) NSString *name;
@end

@interface NSObject(PrintHistorySearchSQL)
+(NSString*)getCreateHistorySearchTableSQL;
@end