//
//  DSHttpProgramsListCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProgramsListCmd+Response.h"
#import "DSHttpProgramsListResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpProgramsListDetail;
@interface DSHttpProgramsListDetail : JSONModel
@property NSString<Optional> *id;
@property NSString<Optional> *video;
@property NSString<Optional> *image;
@property NSString<Optional> *text;
@property NSString<Optional> *type;
@property NSString<Optional> *isPublish;
@property NSString<Optional> *isTop;
@property NSString<Optional> *createOnTime;
@property NSString<Optional> *updateTime;
@end
@implementation DSHttpProgramsListDetail
@end

@interface DSHttpProgramsListContent : JSONModel
@property NSMutableArray<DSHttpProgramsListDetail> *content;
@end
@implementation DSHttpProgramsListContent
@end

@interface DSHttpProgramsListResult()
@property DSHttpProgramsListContent *data;
@end


@implementation DSHttpProgramsListCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{

    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpProgramsListResult *result = (DSHttpProgramsListResult *)self.result;
    if (code>199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpProgramsListContent alloc]initWithDictionary:dic error:(NSError **)&error];
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

@implementation DSHttpProgramsListResult
- (NSMutableArray *)getAllContent{

    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSProgramsListInfo *info = [[DSProgramsListInfo alloc]init];
        DSHttpProgramsListDetail *webInfo = self.data.content[i];
        info.id = webInfo.id;
        info.video = webInfo.video;
        info.image = webInfo.image;
        info.text = webInfo.text;
        info.type = webInfo.type;
        info.isPublish = webInfo.isPublish;
        info.isTop = webInfo.isTop;
        info.createOnTime = webInfo.createOnTime;
        info.updateTime = webInfo.updateTime;
        [arr addObject:info];
    }
    return arr;
}

@end
