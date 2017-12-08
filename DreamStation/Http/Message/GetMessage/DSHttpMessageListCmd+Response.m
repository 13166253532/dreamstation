//
//  DSHttpMessageListCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/9/1.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpMessageListCmd+Response.h"
#import "DSHttpMessageListResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpMessageListItems;
@interface DSHttpMessageListItems : JSONModel
@property NSString<Optional>*id;
@property NSString<Optional>*title;
@property NSString<Optional>*message;
@property NSString<Optional>*sort;
@end
@implementation DSHttpMessageListItems
@synthesize description;
@end


@interface DSHttpMessageListResultData : JSONModel
@property NSMutableArray<DSHttpMessageListItems>*items;
@end
@implementation DSHttpMessageListResultData
@end


@interface DSHttpMessageListResult()
@property DSHttpMessageListResultData *data;
@end

@implementation DSHttpMessageListCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpMessageListResult *result = (DSHttpMessageListResult *)self.result;
    if (code>199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpMessageListResultData alloc]initWithDictionary:dic error:(NSError **)&error];
        if(error){
            [self onRequestFailed:error];
            return;
        }
    }else{
        NSString *memo = [dic objectForKey:@"error_description"];
        [self.result setResultState:kRequestResultFail];
        [self.result setErrMsg:memo];
        NSLog(@"code :%ld errormsg:%@",(long)code,memo);
    }
}

- (void)onRequestFailed:(NSError *)error{
    NSLog(@"Error:%@",error);
    [self.result setErrMsg:[error localizedDescription]];
    [self.result setResultState:kRequestResultFail];
}

@end



@implementation DSHttpMessageListResult
- (NSMutableArray *)getTheAllData{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.data.items.count; i++) {
        DSMessageListInfo *info = [[DSMessageListInfo alloc]init];
        DSHttpMessageListItems *items = [[DSHttpMessageListItems alloc]init];
        items = self.data.items[i];
        info.id = items.id;
        info.title = items.title;
        info.message = items.message;
        info.sort = items.sort;
        [arr addObject:info];
    }
    return arr;
}




@end