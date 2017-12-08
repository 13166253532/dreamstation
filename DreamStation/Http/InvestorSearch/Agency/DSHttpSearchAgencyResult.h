//
//  DSHttpSearchAgencyResult.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/7.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpRequestResult.h"

@interface DSHttpSearchAgencyResult : SNHttpRequestResult
- (NSMutableArray *)getAllAgencyData;
- (NSMutableArray *)getAllAgencyCats;
- (NSMutableArray *)getAllAgencyPartners;
@end
