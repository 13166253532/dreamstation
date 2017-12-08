//
//  FGDBHelper.h
//  FelicityGold
//
//  Created by QPP on 15-7-21.
//  Copyright (c) 2015年 QPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPHistorySearchInfo.h"
#import "HTCitiesListInfo.h"
#import "HTCalendarOrdersInfo.h"
#import "HTCountryListInfo.h"
#import "HTMessageInfo.h"

@interface FGDBHelper : NSObject

+(instancetype)sharedInstance;
//搜索记录
-(void)clearHistorySearch;
-(void)saveHistorySearch:(EPHistorySearchInfo *)messageInfo callBack:(void (^)(BOOL))block;
-(NSMutableArray *)queryAllHistory;
//城市列表
-(void)clearCitiesList;
-(void)saveCitiesList:(HTCitiesListInfo *)messageInfo callBack:(void (^)(BOOL))block;
-(NSMutableArray *)queryAllCities;
//国家列表
-(void)clearCountryList;
-(void)saveCountryList:(HTCountryListInfo *)messageInfo callBack:(void (^)(BOOL))block;
-(NSMutableArray *)queryAllCountry;

//日历订单
-(void)saveCalendarOrders:(HTCalendarOrdersInfo *)calendarInfo callBack:(void (^)(BOOL))block;
-(NSMutableArray *)queryCalendarOrderInfoByDate:(NSString *)time;
-(void)clearCalendarData;

//消息详情
-(void)saveMessage:(HTMessageInfo *)messageInfo callBack:(void (^)(BOOL))block;
-(void)deleteMessage:(NSString *)mid callBack:(void (^)(BOOL))block;

-(NSMutableArray *)queryAllMessage:(NSString *)userId;
-(BOOL)hasUnReaMessage:(NSString *)userId;

-(void)clearMessageData;
-(void)updateMessagePush:(HTMessageInfo *)messagePush callBack:(void (^)(BOOL))block;



@end
