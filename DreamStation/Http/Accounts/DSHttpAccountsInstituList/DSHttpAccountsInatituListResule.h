//
//  DSHttpAccountsInatituListResule.h
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpRequestResult.h"

@interface DSHttpAccountsInatituListResule : SNHttpRequestResult
- (NSMutableArray *)getAllContent;
- (NSString *)getAllnumberOfElements;
@end
