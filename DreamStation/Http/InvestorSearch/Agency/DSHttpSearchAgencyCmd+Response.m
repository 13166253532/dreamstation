//
//  DSHttpSearchAgencyCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/9/7.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpSearchAgencyCmd+Response.h"
#import "DSHttpSearchAgencyResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpSearchAgencypartners;
@interface DSHttpSearchAgencypartners : JSONModel
@property NSString<Optional>*name;
@property NSString<Optional>*avatar;
@property NSString<Optional>*position;
@property NSString<Optional>*brief;
@end
@implementation DSHttpSearchAgencypartners
@end

@protocol DSHttpSearchAgencyCats;
@interface DSHttpSearchAgencyCats : JSONModel
@property NSString<Optional>*catName;
@property NSString<Optional>*description;
@end
@implementation DSHttpSearchAgencyCats
@synthesize description;
@end


@protocol DSHttpSearchAgencyContent;
@interface DSHttpSearchAgencyContent : JSONModel
@property NSString<Optional>*id;
@property NSString<Optional>*avatar;
@property NSString<Optional>*card_no;
@property NSString<Optional>*company;
@property NSString<Optional>*logo;
@property NSString<Optional>*licence;
@property NSString<Optional>*phone;
@property NSString<Optional>*mail;
@property NSString<Optional>*address;
@property NSString<Optional>*homePage;
@property NSString<Optional>*introduction;
@property NSString<Optional>*cases;
@property NSString<Optional>*investMax;
@property NSString<Optional>*investMin;
@property NSMutableArray<DSHttpSearchAgencyCats,Optional>*cats;
@property NSMutableArray<DSHttpSearchAgencypartners,Optional>*partners;
@property NSString<Optional>*video_url;
@property NSString<Optional>*video_title;
@property NSString<Optional>*video_pic;
@property NSString<Optional>*createTime;
@property NSString<Optional>*adminLogin;
@property NSString<Optional>*followNum;
@end
@implementation DSHttpSearchAgencyContent
@end

@interface DSHttpSearchAgencyData: JSONModel
@property NSMutableArray<DSHttpSearchAgencyContent,Optional>*content;
@end
@implementation DSHttpSearchAgencyData
@end

@interface DSHttpSearchAgencyResult()
@property DSHttpSearchAgencyData *data;
@end

@implementation DSHttpSearchAgencyCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpSearchAgencyResult *result = (DSHttpSearchAgencyResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpSearchAgencyData alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpSearchAgencyResult

- (NSMutableArray *)getAllAgencyData{
    NSMutableArray *list = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSSearchAgencyInfo *info = [[DSSearchAgencyInfo alloc]init];
        DSHttpSearchAgencyContent *webInfo = self.data.content[i];
        info.id = webInfo.id;
        info.avatar = webInfo.avatar;
        info.card_no = webInfo.card_no;
        info.company = webInfo.company;
        info.logo = webInfo.logo;
        info.licence = webInfo.licence;
        info.phone = webInfo.phone;
        info.mail = webInfo.mail;
        info.address = webInfo.address;
        info.homePage = webInfo.homePage;
        info.introduction = webInfo.introduction;
        info.cases = webInfo.cases;
        info.investMax = webInfo.investMax;
        info.investMin = webInfo.investMin;
        //info.cats = self.getAllAgencyCats;
        info.partners = self.getAllAgencyPartners;
         NSMutableArray *catsList = [NSMutableArray array];
        for (int j=0; j<webInfo.cats.count; j++) {
            DSSearchAgencyCats *info = [[DSSearchAgencyCats alloc]init];
            DSHttpSearchAgencyCats *catInfo = webInfo.cats[j];
            info.catName = catInfo.catName;
            info.descriptions = catInfo.description;
            [catsList addObject:info];
        }
        info.cats = catsList;
        
        
        
        info.video_pic = webInfo.video_pic;
        info.video_url = webInfo.video_url;
        info.video_title = webInfo.video_title;
        info.createTime = webInfo.createTime;
        info.followNum = webInfo.followNum;
        info.adminLogin = webInfo.adminLogin;
        [list addObject:info];
    }
    return list;
}

- (NSMutableArray *)getAllAgencyCats{
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i<self.data.content.count; i++) {
        DSSearchAgencyCats *info = [[DSSearchAgencyCats alloc]init];
        DSHttpSearchAgencyContent *webInfo = self.data.content[i];
        for (int j = 0; j<webInfo.cats.count; j++) {
            DSHttpSearchAgencyCats *catInfo = webInfo.cats[i];
            info.catName = catInfo.catName;
            info.descriptions = catInfo.description;
            [list addObject:info];
        }
    }
    return list;
}

- (NSMutableArray *)getAllAgencyPartners{
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i<self.data.content.count; i++) {
        DSSearchAgencyPartners *info = [[DSSearchAgencyPartners alloc]init];
        DSHttpSearchAgencyContent *webInfo = self.data.content[i];
        for (int j = 0; j<webInfo.partners.count; j++) {
            DSHttpSearchAgencypartners *partnersInfo = webInfo.partners[i];
            info.name = partnersInfo.name;
            info.avatar = partnersInfo.avatar;
            info.position = partnersInfo.position;
            info.brief = partnersInfo.brief;
            [list addObject:info];
        }
    }
    return list;
}

@end
