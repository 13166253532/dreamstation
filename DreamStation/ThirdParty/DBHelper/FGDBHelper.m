//
//  FGDBHelper.m
//  FelicityGold
//
//  Created by QPP on 15-7-21.
//  Copyright (c) 2015年 QPP. All rights reserved.
//

#import "FGDBHelper.h"


@implementation FGDBHelper
+(instancetype)sharedInstance{
    static FGDBHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedInstance = [[FGDBHelper alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - 搜索记录
-(void)saveHistorySearch:(EPHistorySearchInfo *)messageInfo callBack:(void (^)(BOOL))block{
    
    if (messageInfo == nil) {
        return;
    }
    LKDBHelper* dbHelper = [EPHistorySearchInfo getUsingLKDBHelper];
    BOOL __block tranResult = YES;
    [dbHelper executeForTransaction:^(LKDBHelper* helper){
        BOOL result = NO;
        result = [self saveHistoryInfo:messageInfo];
        if (!result) {
            
        }
        tranResult = result;
        return result;
    }];
    block(tranResult);
    
}

-(BOOL)saveHistoryInfo:(EPHistorySearchInfo *)historyInfo
{
    if ([self queryHasHistoryByName:historyInfo.name]){
        return YES;
    }else if ([self queryAllHistory].count>4){
        [self deleteThefirstName];
        LKDBHelper* dbHelper = [EPHistorySearchInfo getUsingLKDBHelper];
        return [dbHelper insertToDB:historyInfo];
    }else{
        LKDBHelper* dbHelper = [EPHistorySearchInfo getUsingLKDBHelper];
        return [dbHelper insertToDB:historyInfo];
    }
}

-(void)clearHistorySearch {
    [LKDBHelper clearTableData:[EPHistorySearchInfo class]];
}


-(NSMutableArray *)queryAllHistory{
    LKDBHelper* dbHelper = [EPHistorySearchInfo getUsingLKDBHelper];
    return [dbHelper search:[EPHistorySearchInfo class] column:nil where:nil orderBy:nil offset:0 count:0];
}
-(BOOL)queryHasHistoryByName:(NSString *)str{
    
    LKDBHelper* dbHelper = [EPHistorySearchInfo getUsingLKDBHelper];
    NSDictionary *where = [NSDictionary dictionaryWithObjectsAndKeys:str,@"name",nil];
    NSMutableArray *array = [dbHelper search:[EPHistorySearchInfo class] column:nil where:where orderBy:nil offset:0 count:0];
    return [array count] > 0?YES:NO;
    
}

-(void)deleteThefirstName{
    LKDBHelper* dbHelper = [EPHistorySearchInfo getUsingLKDBHelper];
    NSMutableArray *arr=[self queryAllHistory];
    EPHistorySearchInfo *info=arr[0];
    NSDictionary *where = [NSDictionary dictionaryWithObjectsAndKeys:info.name,@"name",nil];
    [dbHelper deleteWithClass:[EPHistorySearchInfo class] where:where callback:^(BOOL result) {
        
        
        if (result){
             NSLog(@"删除成功");
        }
       
    }];
    
    
}
#pragma mark - 城市列表
-(void)clearCitiesList {
    [LKDBHelper clearTableData:[HTCitiesListInfo class]];
}
-(void)saveCitiesList:(HTCitiesListInfo *)messageInfo callBack:(void (^)(BOOL))block {
    if (messageInfo == nil) {
        return;
    }
    LKDBHelper* dbHelper = [HTCitiesListInfo getUsingLKDBHelper];
    BOOL __block tranResult = YES;
    [dbHelper executeForTransaction:^(LKDBHelper* helper){
        BOOL result = NO;
        result = [self saveCitiesListInfo:messageInfo];
        if (!result) {
            
        }
        tranResult = result;
        return result;
    }];
    block(tranResult);
}

-(BOOL)saveCitiesListInfo:(HTCitiesListInfo *)citiesListInfo {
    LKDBHelper* dbHelper = [HTCitiesListInfo getUsingLKDBHelper];
    return [dbHelper insertToDB:citiesListInfo];
}

-(NSMutableArray *)queryAllCities {
    LKDBHelper* dbHelper = [HTCitiesListInfo getUsingLKDBHelper];
    return [dbHelper search:[HTCitiesListInfo class] column:nil where:nil orderBy:nil offset:0 count:0];
}

#pragma mark - 国家列表
-(void)clearCountryList{
    [LKDBHelper clearTableData:[HTCountryListInfo class]];
}
-(void)saveCountryList:(HTCountryListInfo *)messageInfo callBack:(void (^)(BOOL))block{
    if (messageInfo == nil) {
        return;
    }
    LKDBHelper* dbHelper = [HTCountryListInfo getUsingLKDBHelper];
    BOOL __block tranResult = YES;
    [dbHelper executeForTransaction:^(LKDBHelper* helper){
        BOOL result = NO;
        result = [self saveCountryListInfo:messageInfo];
        if (!result) {
            
        }
        tranResult = result;
        return result;
    }];
    block(tranResult);
}

-(BOOL)saveCountryListInfo:(HTCountryListInfo *)citiesListInfo {
    LKDBHelper* dbHelper = [HTCountryListInfo getUsingLKDBHelper];
    return [dbHelper insertToDB:citiesListInfo];
}


-(NSMutableArray *)queryAllCountry{
    LKDBHelper* dbHelper = [HTCountryListInfo getUsingLKDBHelper];
    return [dbHelper search:[HTCountryListInfo class] column:nil where:nil orderBy:nil offset:0 count:0];
}



#pragma mark - 日历订单

-(void)saveCalendarOrders:(HTCalendarOrdersInfo *)calendarInfo callBack:(void (^)(BOOL))block{
    if (calendarInfo == nil) {
        return;
    }
    LKDBHelper* dbHelper = [HTCalendarOrdersInfo getUsingLKDBHelper];
    BOOL __block tranResult = YES;
    [dbHelper executeForTransaction:^(LKDBHelper* helper){
        BOOL result = NO;
        result = [self saveCalendarOrder:calendarInfo];
        if (!result) {
            
        }
        tranResult = result;
        return result;
    }];
    block(tranResult);

}
-(BOOL)saveCalendarOrder:(HTCalendarOrdersInfo *)calendarOrderInfo {
    LKDBHelper* dbHelper = [HTCalendarOrdersInfo getUsingLKDBHelper];
    return [dbHelper insertToDB:calendarOrderInfo];
}

-(NSMutableArray *)queryCalendarOrderInfoByDate:(NSString *)time{
    LKDBHelper* dbHelper = [HTCalendarOrdersInfo getUsingLKDBHelper];
    NSDictionary *where = [NSDictionary dictionaryWithObjectsAndKeys:time,@"date",nil];
    return [dbHelper search:[HTCalendarOrdersInfo class] column:nil where:where orderBy:nil offset:0 count:0];
}

-(void)clearCalendarData{
    [LKDBHelper clearTableData:[HTCalendarOrdersInfo class]];
}

#pragma mark - 消息详情


-(void)saveMessage:(HTMessageInfo *)messageInfo callBack:(void (^)(BOOL))block{
    
    if (messageInfo == nil) {
        return;
    }
    LKDBHelper* dbHelper = [HTMessageInfo getUsingLKDBHelper];
    BOOL __block tranResult = YES;
    [dbHelper executeForTransaction:^(LKDBHelper* helper){
        BOOL result = NO;
        result = [self saveMessage:messageInfo];
        if (!result) {
            
        }
        tranResult = result;
        return result;
    }];
    block(tranResult);
    
}
-(BOOL)saveMessage:(HTMessageInfo *)messageInfo {
    LKDBHelper* dbHelper = [HTMessageInfo getUsingLKDBHelper];
    return [dbHelper insertToDB:messageInfo];
}

-(NSMutableArray *)queryAllMessage:(NSString *)userId{
    LKDBHelper* dbHelper = [HTMessageInfo getUsingLKDBHelper];
    
    
    NSDictionary *where = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"accountId",nil];
    
    return [dbHelper search:[HTMessageInfo class] column:nil where:where orderBy:@"time desc" offset:0 count:0];
}

-(BOOL)hasUnReaMessage:(NSString *)userId{
    LKDBHelper* dbHelper = [HTMessageInfo getUsingLKDBHelper];
    NSDictionary *where = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"isRead",userId,@"accountId",nil];
    
    NSMutableArray *arr=[dbHelper search:[HTMessageInfo class] column:nil where:where orderBy:nil offset:0 count:0];
    return [arr count]>0 ? true : false ;
    
}





-(void)clearMessageData{
    [LKDBHelper clearTableData:[HTMessageInfo class]];
}

-(void)updateMessagePush:(HTMessageInfo *)messagePush callBack:(void (^)(BOOL))block{
    if (messagePush == nil ) {
        return;
    }
    LKDBHelper* dbHelper = [HTMessageInfo getUsingLKDBHelper];
    BOOL __block tranResult = YES;
    [dbHelper executeForTransaction:^(LKDBHelper* helper){
        BOOL result = NO;
        result = [self updateMessagePush:messagePush];
        if (!result) {
            
        }
        
        tranResult = result;
        return result;
    }];
    block(tranResult);
}
-(BOOL)updateMessagePush:(HTMessageInfo *)messagePush
{
    LKDBHelper* dbHelper = [HTMessageInfo getUsingLKDBHelper];
//    NSDictionary *where = [NSDictionary dictionaryWithObjectsAndKeys:messagePush.id ,@"id",messagePush.type,@"type",messagePush.reason,@"reason",messagePush.title,@"title",messagePush.isRead,@"isRead",nil];
    NSDictionary *where = [NSDictionary dictionaryWithObjectsAndKeys:messagePush.mId,@"mId",nil];
    return [dbHelper updateToDB:messagePush where:where];
}

-(void)deleteMessage:(NSString *)mid callBack:(void (^)(BOOL))block{
    LKDBHelper *dbHelper = [HTMessageInfo getUsingLKDBHelper];
    BOOL __block tranResult = YES;
    NSDictionary *where = [NSDictionary dictionaryWithObjectsAndKeys:mid,@"mId",nil];
    [dbHelper deleteWithClass:[HTMessageInfo class] where:where callback:^(BOOL result){
        tranResult = result;
    }];
    block(tranResult);
}



@end
