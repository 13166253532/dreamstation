//
//  DSHttpLoginCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/14.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpLoginCmd+Response.h"
#import "DSHttpLoginResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpLoginResultCats;
@interface DSHttpLoginResultCats : JSONModel
@property NSString<Optional> *description;
@property NSString<Optional> *name;
@end
@implementation DSHttpLoginResultCats
@synthesize description;
@end


@interface DSHttpLoginResultAccessToken : JSONModel
@property NSString<Optional> *token_type;
@property NSString<Optional> *access_token;
@property NSString<Optional> *expires_in;
@end
@implementation DSHttpLoginResultAccessToken
@end

@interface DSHttpParkLoginInstitutionerResult : JSONModel
@property NSMutableArray<DSHttpLoginResultCats> *cats;
@end
@implementation DSHttpParkLoginInstitutionerResult
@end

@interface DSHttpParkLoginIndividualResult : JSONModel
@property NSMutableArray<DSHttpLoginResultCats> *cats;
@end
@implementation DSHttpParkLoginIndividualResult
@end


@interface DSHttpParkLoginResult : JSONModel
@property NSString<Optional> *name;
@property NSString<Optional> *parkName;
@property NSString<Optional> *job;
@property NSString<Optional> *phone;
@end
@implementation DSHttpParkLoginResult
@end
@interface DSHttpInstitutionInfo : JSONModel
@property NSString<Optional> *id;
@property NSString<Optional> *company;
@end
@implementation DSHttpInstitutionInfo
@end
@interface DSHttpInstitutionerInfo : JSONModel
@property DSHttpInstitutionInfo<Optional> *institution;
@property NSString<Optional> *title;
@property NSString<Optional> *phone;
@end
@implementation DSHttpInstitutionerInfo
@end

@interface DSHttpLoginResultPersonInfo : JSONModel
/***用户ID*/
@property NSString<Optional> *id;
/***用户姓名*/
@property NSString<Optional> *name;
/***用户身份*/
@property NSString<Optional> *role;
/***登录帐号*/
@property NSString<Optional> *login;
/**是否认证*/
@property NSString<Optional> *authorized;

/**用户头像*/
@property NSString<Optional> *avatar;
@property DSHttpParkLoginResult<Optional> *park;


@property DSHttpInstitutionerInfo<Optional> *institutioner;
//@property DSHttpParkLoginIndividualResult<Optional> *individual;
//@property DSHttpParkLoginInstitutionerResult<Optional> *institutioner;

@end
@implementation DSHttpLoginResultPersonInfo
@end


@interface DSHttpLoginResultData : JSONModel
@property DSHttpLoginResultAccessToken *accesstoken;
@property DSHttpLoginResultPersonInfo *personInfo;
@end
@implementation DSHttpLoginResultData
@end


@interface DSHttpLoginResult()
@property DSHttpLoginResultData *data;
@end


@implementation DSHttpLoginCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpLoginResult *result = (DSHttpLoginResult *)self.result;
    if (code >199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpLoginResultData alloc]initWithDictionary:dic error:(NSError **)&error];
        if (error) {
            [self onRequestFailed:error];
            return;
        }
    }else{
        NSString *memo = [[NSString alloc]init];
        if (code == 403 ) {
            memo = [dic objectForKey:@"error"];
        }else {
            memo = [dic objectForKey:@"error_description"];
        }
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


@implementation DSHttpLoginResult

- (NSString *)getAccess_token{
    return self.data.accesstoken.access_token;
}

- (NSString *)getToken_type{
    return self.data.accesstoken.token_type;
}

- (NSString *)getId{
    return self.data.personInfo.id;
}

- (NSString *)getRole{
    return self.data.personInfo.role;
}
- (NSString *)getPhone{
    return self.data.personInfo.institutioner.phone;
}

- (NSString *)getLoginPhone{
    return self.data.personInfo.login;
}

- (NSString *)getisAuthorized{
    return self.data.personInfo.authorized;
    
}
- (NSString *)getisName{
    //return self.data.personInfo.name;
    return [self tihuanName:self.data.personInfo.name];
}
- (NSString *)getisAvatar{
    return self.data.personInfo.avatar;
}
- (NSString *)getisParkName{
    //return self.data.personInfo.park.name;
    return [self tihuanName:self.data.personInfo.park.name];
}
- (NSString *)getisParkNames{
    //return self.data.personInfo.park.name;
    return self.data.personInfo.park.parkName;
}
- (NSString *)getisParkperPhone{
    //return self.data.personInfo.park.name;
    return self.data.personInfo.park.phone;
}
- (NSString *)getisParkJob{
    //return self.data.personInfo.park.name;
    return [self tihuanName:self.data.personInfo.park.job];
}

- (NSString *)getInstitutionId{
    return self.data.personInfo.institutioner.institution.id;
}
- (NSString *)getInstitutionCompany{
    return self.data.personInfo.institutioner.institution.company;
}
- (NSString *)getInstitutionJob{
    return self.data.personInfo.institutioner.title;
}
- (NSString *)tihuanName:(NSString *)string{
    if (string == nil) {
        string = @"";
    }
    return string;
}


@end


