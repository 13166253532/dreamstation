//
//  DSHttpUploadFileCmd.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePutFileCmd.h"

@interface DSHttpUploadFileCmd : SNHttpBasePutFileCmd
+(HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
