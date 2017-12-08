//
//  HTMessageInfo.h
//  HiTeacher
//
//  Created by QPP on 16/7/12.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

typedef NS_ENUM(NSInteger,MessageType) {
    Message_confirmed=1,
    Message_cancelled,
    Message_completed,
    Message_timeChange,
    
};


@interface HTMessageInfo : NSObject
@property NSString *time;
@property NSString *content;
@property NSString *type;
@property NSString *id;
@property NSString *reason;
@property NSString *accountId;
@property NSString *title;
@property NSString *mId;
@property NSString *isRead; //1已读，0未读
@end

@interface NSObject(PrintMessageListSQL)
+(NSString*)getCitiesListSQL;
@end
