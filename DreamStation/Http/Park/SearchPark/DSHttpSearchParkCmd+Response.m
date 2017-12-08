//
//  DSHttpSearchParkCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSearchParkCmd+Response.h"
#import "DSHttpSearchParkResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpSearchParkAddressDetail;
@interface DSHttpSearchParkAddressDetail : JSONModel
@property NSString<Optional> *city;
@property NSString<Optional> *detailAddress;
@end
@implementation DSHttpSearchParkAddressDetail
@synthesize description;
@end


@protocol DSHttpSearchParkContent;
@interface DSHttpSearchParkContent : JSONModel
@property NSString<Optional>*id;
@property NSString<Optional>*parkName;
@property NSString<Optional>*parkLogo;
@property NSString<Optional>*parkImages;
@property NSString<Optional>*hasFree;
@property NSString<Optional>*hasService;
@property NSString<Optional>*address;
@property NSString<Optional>*images;
@property NSString<Optional>*introduction;
@property NSString<Optional>*cases;
@property NSString<Optional>*description;
@property NSString<Optional>*videoUrl;
@property NSString<Optional>*videoTitle;
@property NSString<Optional>*videoImage;
@property NSString<Optional>*login;
@property NSString<Optional>*createTime;
@property NSMutableArray<DSHttpSearchParkAddressDetail> *detailAddress;

@end
@implementation DSHttpSearchParkContent
@synthesize description;
@end

@interface DSHttpSearchParkData : JSONModel
@property NSMutableArray<DSHttpSearchParkContent,Optional>*content;
@end
@implementation DSHttpSearchParkData
@end

@interface DSHttpSearchParkResult()
@property DSHttpSearchParkData *data;
@end

@implementation DSHttpSearchParkCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpSearchParkResult *result = (DSHttpSearchParkResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpSearchParkData alloc]initWithDictionary:dic error:(NSError **)&error];
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

@end

@implementation DSHttpSearchParkResult
- (NSMutableArray *)getSearchParkData{
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i<self.data.content.count; i++) {
        
        DSSearchParkInfo *info = [[DSSearchParkInfo alloc]init];
        DSHttpSearchParkContent *webInfo = self.data.content[i];
        info.id = webInfo.id;
        info.parkName = webInfo.parkName;
        info.parkLogo = webInfo.parkLogo;
        info.parkImages = webInfo.parkImages;
        info.hasFree = webInfo.hasFree;
        info.hasService = webInfo.hasService;
        info.address = webInfo.address;
        info.images = webInfo.images;
        info.introduction = webInfo.introduction;
        info.cases = webInfo.cases;
        info.descriptions = webInfo.description;
        info.videoUrl = webInfo.videoUrl;
        info.videoTitle = webInfo.videoTitle;
        info.videoImage = webInfo.videoImage;
        info.createTime = webInfo.createTime;
        info.login = webInfo.login;
        for (int j=0; j<webInfo.detailAddress.count; j++) {
            DSHttpSearchParkAddressDetail *webAddress = webInfo.detailAddress[j];
            DSParkListDetailAddressinfo *addressInfo = [[DSParkListDetailAddressinfo alloc]init];
            addressInfo.city = webAddress.city;
            addressInfo.detailAddress = webAddress.detailAddress;
            //info.detailAddressArray
            [info.detailAddressArray addObject:addressInfo];
        }
        [list addObject:info];
    }

    return list;
}
@end


