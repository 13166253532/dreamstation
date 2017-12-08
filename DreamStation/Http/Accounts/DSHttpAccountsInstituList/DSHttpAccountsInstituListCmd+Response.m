//
//  DSHttpAccountsInstituListCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpAccountsInstituListCmd+Response.h"
#import "DSHttpAccountsInatituListResule.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpAccountsInatituListPartners;
@interface DSHttpAccountsInatituListPartners : JSONModel
@property NSString<Optional> *brief;
@property NSString<Optional> *name;
@property NSString<Optional> *position;
@property NSString<Optional> *avatar;
@end
@implementation DSHttpAccountsInatituListPartners
@synthesize description;
@end



@protocol DSHttpAccountsInatituListCats;
@interface DSHttpAccountsInatituListCats : JSONModel
@property NSString<Optional> *catName;
@property NSString<Optional> *description;
@end
@implementation DSHttpAccountsInatituListCats
@synthesize description;
@end



@protocol DSHttpAccountsInatituListDetail;
@interface DSHttpAccountsInatituListDetail : JSONModel
@property NSString<Optional> *id;
@property NSString<Optional> *investMin;
@property NSString<Optional> *video_url;
@property NSString<Optional> *licence;
@property NSString<Optional> *company;
@property NSString<Optional> *adminLogin;
@property NSString<Optional> *mail;
@property NSString<Optional> *video_title;
@property NSString<Optional> *homePage;
@property NSString<Optional> *card_no;
@property NSString<Optional> *phone;
@property NSString<Optional> *avatar;
@property NSString<Optional> *introduction;
@property NSString<Optional> *logo;
@property NSString<Optional> *video_pic;
@property NSString<Optional> *cases;
@property NSString<Optional> *address;
@property NSString<Optional> *investMax;
@property NSString<Optional> *followCount;
@property NSString<Optional> *createTime;
@property NSMutableArray<DSHttpAccountsInatituListPartners> *partners;
@property NSMutableArray<DSHttpAccountsInatituListCats> *cats;
@end
@implementation DSHttpAccountsInatituListDetail
@synthesize description;
@end


@interface DSHttpAccountsInatituListContent : JSONModel
@property NSMutableArray<DSHttpAccountsInatituListDetail> *content;
@property NSString<Optional> *numberOfElements;
@end
@implementation DSHttpAccountsInatituListContent
@end



@interface DSHttpAccountsInatituListResule()
@property DSHttpAccountsInatituListContent *data;

@end


@implementation DSHttpAccountsInstituListCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpAccountsInatituListResule *result = (DSHttpAccountsInatituListResule *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpAccountsInatituListContent alloc]initWithDictionary:dic error:(NSError **)&error];
        
        
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



@implementation DSHttpAccountsInatituListResule

- (NSMutableArray *)getAllContent{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSAccountsInstituListInfo *info = [[DSAccountsInstituListInfo alloc]init];
        DSHttpAccountsInatituListDetail *webInfo = self.data.content[i];
        info.partners = [NSMutableArray array];
        info.cats = [NSMutableArray array];
        info.investMin = webInfo.investMin;
        info.video_url = webInfo.video_url;
        info.licence = webInfo.licence;
        info.company = webInfo.company;
        info.adminLogin = webInfo.adminLogin;
        info.mail = webInfo.mail;
        info.video_title = webInfo.video_title;
        info.homePage = webInfo.homePage;
        info.id = webInfo.id;
        info.card_no = webInfo.card_no;
        info.phone = webInfo.phone;
        info.avatar = webInfo.avatar;
        info.introduction = webInfo.introduction;
        info.logo = webInfo.logo;
        info.video_pic = webInfo.video_pic;
        info.address = webInfo.address;
        info.cases = webInfo.cases;
        info.createTime = webInfo.createTime;
        
        if (webInfo.followCount == nil) {
            info.followNum = @"0";
        }else{
           info.followNum = webInfo.followCount;
        }
        info.investMax = webInfo.investMax;
        for (int j=0; j<webInfo.partners.count; j++) {
            DSAccountsInstituListPartnersInfo *parInfo = [[DSAccountsInstituListPartnersInfo alloc]init];
            DSHttpAccountsInatituListPartners *par = webInfo.partners[j];
            parInfo.brief = par.brief;
            parInfo.name = par.name;
            parInfo.position = par.position;
            parInfo.avatar = par.avatar;
            [info.partners addObject:parInfo];
        }
        for (int index=0; index<webInfo.cats.count; index++) {
            DSAccountsInstituListCatsInfo *catsInfo = [[DSAccountsInstituListCatsInfo alloc]init];
            DSHttpAccountsInatituListCats *cats = webInfo.cats[index];
            catsInfo.catName = cats.catName;
            catsInfo.descriptions = cats.description;
            [info.cats addObject:catsInfo];
        }
        [arr addObject:info];
    }
    return arr;
}
- (NSString *)getAllnumberOfElements{
    return self.data.numberOfElements;
}



@end