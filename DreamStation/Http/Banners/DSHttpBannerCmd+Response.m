//
//  DSHttpBannerCmd+Response.m
//  DreamStation
//
//  Created by QPP on 16/8/4.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpBannerCmd+Response.h"
#import "DSHttpBannerResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpBannerResultDetail;
@interface DSHttpBannerResultDetail : JSONModel
@property NSString<Optional> *isPublish;
@property NSString<Optional> *video;
@property NSString<Optional> *image;
@property NSString<Optional> *text;
@end
@implementation DSHttpBannerResultDetail

@end



@interface DSHttpBannerResultItems : JSONModel
@property NSMutableArray<DSHttpBannerResultDetail> *items;
@end
@implementation DSHttpBannerResultItems

@end



@interface DSHttpBannerResult ()
@property DSHttpBannerResultItems *data;
@end


@implementation DSHttpBannerCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpBannerResult *result = (DSHttpBannerResult *)self.result;
    if (code >199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpBannerResultItems alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpBannerResult
-(NSMutableArray *)getBannerList{

    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0;i<self.data.items.count;i++){
        DSHttpBannerResultDetail *deInfo=self.data.items[i];
        DSBannerInfo *info=[[DSBannerInfo alloc]init];
        
        info.video=deInfo.video;
        info.image=deInfo.image;
        info.text=deInfo.text;
        info.isPublish = deInfo.isPublish;
        [arr addObject:info];
  
    }

    return arr;
}

@end
