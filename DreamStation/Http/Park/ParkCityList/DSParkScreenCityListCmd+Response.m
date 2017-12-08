//
//  DSParkScreenCityListCmd+Response.m
//  DreamStation
//
//  Created by xjb on 2016/11/28.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSParkScreenCityListCmd+Response.h"
#import "DSParkScreenCityListResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"



@interface DSHttpScreenParkListContent : JSONModel
@property NSMutableArray *cities;
@end
@implementation DSHttpScreenParkListContent
@end



@interface DSParkScreenCityListResult()
@property DSHttpScreenParkListContent *data;
@end

@implementation DSParkScreenCityListCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSParkScreenCityListResult *result = (DSParkScreenCityListResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpScreenParkListContent alloc]initWithDictionary:dic error:(NSError **)&error];
        if (error) {
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


@implementation DSParkScreenCityListResult

- (NSMutableArray *)getScreenCityList{
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"全部"];
    for (int i = 0; i<self.data.cities.count;i++ ) {
       // NSLog(@"%@",self.data.cities[i]);
        [arr addObject:self.data.cities[i]];
    }
    return arr;
}


@end
