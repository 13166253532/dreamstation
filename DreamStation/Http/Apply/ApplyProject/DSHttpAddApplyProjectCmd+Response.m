//
//  DSHttpAddApplyProjectCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/15.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpAddApplyProjectCmd+Response.h"
#import "DSHttpAddApplyProjectResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@interface DSHttpAddApplyProjectDetail : JSONModel
@property NSString<Optional>*id;
@property NSString<Optional>*status;
@property NSString<Optional>*user_id;
@end
@implementation DSHttpAddApplyProjectDetail
@end

@interface DSHttpAddApplyProjectResult()
@property DSHttpAddApplyProjectDetail *data;
@end

@implementation DSHttpAddApplyProjectCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpAddApplyProjectResult *result = (DSHttpAddApplyProjectResult *)self.result;
    if (code>199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpAddApplyProjectDetail alloc]initWithDictionary:dic error:(NSError **)&error];
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

@implementation DSHttpAddApplyProjectResult
- (NSMutableArray *)getData{

    NSMutableArray *list = [NSMutableArray array];
    DSAddApplyProjectInfo *info = [[DSAddApplyProjectInfo alloc]init];
    info.id = self.data.id;
    info.status = self.data.status;
    info.user_id = self.data.user_id;
    [list addObject:info];
    return list;
}
@end
