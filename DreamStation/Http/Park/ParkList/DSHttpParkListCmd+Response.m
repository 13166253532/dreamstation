//
//  DSHttpParkListCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpParkListCmd+Response.h"
#import "DSHttpParkListResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"


@protocol DSHttpParkListDetailAddressDetail;
@interface DSHttpParkListDetailAddressDetail : JSONModel
@property NSString<Optional> *city;
@property NSString<Optional> *detailAddress;
@end
@implementation DSHttpParkListDetailAddressDetail
@synthesize description;
@end


@protocol DSHttpParkListDetail;
@interface DSHttpParkListDetail : JSONModel
@property NSString<Optional> *id;
/***园区名*/
@property NSString<Optional> *parkName;
/***园区LOGO*/
@property NSString<Optional> *parkLogo;
/***园区图片*/
@property NSString<Optional> *parkImages;
/***是否免费*/
@property NSString<Optional> *hasFree;
/***是否提供服务*/
@property NSString<Optional> *hasService;
/***地址*/
@property NSString<Optional> *address;
/***图片*/
@property NSString<Optional> *images;
/*** */
@property NSString<Optional> *introduction;
/***案例*/
@property NSString<Optional> *cases;
/***描述*/
@property NSString<Optional> *description;
/***视频URL*/
@property NSString<Optional> *videoUrl;
/***园区视频介绍*/
@property NSString<Optional> *videoTitle;
/***园区视频截图*/
@property NSString<Optional> *videoImage;
/****/
@property NSString<Optional> *login;
/****/
@property NSString<Optional> *createTime;
@property NSMutableArray<DSHttpParkListDetailAddressDetail> *detailAddress;

@end
@implementation DSHttpParkListDetail
@synthesize description;
@end


@interface DSHttpParkListContent : JSONModel
@property NSMutableArray<DSHttpParkListDetail> *content;
@end
@implementation DSHttpParkListContent
@end



@interface DSHttpParkListResult()
@property DSHttpParkListContent *data;
@end


@implementation DSHttpParkListCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpParkListResult *result = (DSHttpParkListResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpParkListContent alloc]initWithDictionary:dic error:(NSError **)&error];
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

@implementation DSHttpParkListResult

- (NSMutableArray *)getAllContents{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSSearchParkInfo *info = [[DSSearchParkInfo alloc]init];
        DSHttpParkListDetail *webinfo = [[DSHttpParkListDetail alloc]init];
        webinfo = self.data.content[i];
        info.id = webinfo.id;
        info.createTime = webinfo.createTime;
        info.login = webinfo.login;
        info.parkLogo = webinfo.parkLogo;
        info.descriptions = webinfo.description;
        info.videoUrl = webinfo.videoUrl;
        info.parkImages = webinfo.parkImages;
        info.hasService = webinfo.hasService;
        info.introduction = webinfo.introduction;
        info.videoTitle = webinfo.videoTitle;
        info.videoImage = webinfo.videoImage;
        info.hasFree = webinfo.hasFree;
        info.address = webinfo.address;
        info.cases = webinfo.cases;
        info.parkName = webinfo.parkName;
        info.images = webinfo.images;
        for (int j=0; j<webinfo.detailAddress.count; j++) {
            DSHttpParkListDetailAddressDetail *webAddress = webinfo.detailAddress[j];
            DSParkListDetailAddressinfo *addressInfo = [[DSParkListDetailAddressinfo alloc]init];
            addressInfo.city = webAddress.city;
            addressInfo.detailAddress = webAddress.detailAddress;
            //info.detailAddressArray
            [info.detailAddressArray addObject:addressInfo];
        }
        [arr addObject:info];
    }
    return arr;
}
@end