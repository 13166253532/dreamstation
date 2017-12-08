//
//  DSHttpRegisterCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/7/13.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpRegisterCmd+Response.h"
#import "DSHttpRegisterResult.h"
#import "JSONModel.h"

@protocol DSHttpRegisterResultScope;
@interface DSHttpRegisterResultScope : JSONModel
@property NSString<Optional> *read;
@property NSString<Optional> *write;
@end
@implementation DSHttpRegisterResultScope
@end

@protocol DSHttpRegisterResultAccessToken;
@interface DSHttpRegisterResultAccessToken : JSONModel
@property NSString<Optional> *token_type;
@property NSString<Optional> *access_token;
@property NSString<Optional> *expires_in;
@property NSString<Optional> *refresh_token;
@property NSMutableArray<DSHttpRegisterResultScope> *scope;
@property NSString<Optional> *valid;
@end
@implementation DSHttpRegisterResultAccessToken
@end

@protocol DSHttpRegisterResultCats;
@interface DSHttpRegisterResultCats:JSONModel
@property NSString<Optional> *domain;
@property NSString<Optional> *investPhase;
@property NSString<Optional> *region;
@property NSString<Optional> *currency;
@property NSString<Optional> *investMax;
@property NSString<Optional> *investMin;
@end
@implementation DSHttpRegisterResultCats
@end

@protocol DSHttpRegisterResultIndividual;
@interface DSHttpRegisterResultIndividual:JSONModel
@property NSString<Optional> *introduction;
@property NSArray<Optional> *cases;
@property NSArray<DSHttpRegisterResultCats> *cats;
@end
@implementation DSHttpRegisterResultIndividual
@end

@protocol DSHttpRegisterResultCompany;
@interface DSHttpRegisterResultCompany : JSONModel
@property NSString<Optional> *name;
@property NSString<Optional> *licenceUrl;
@property NSString<Optional> *address;
@property NSString<Optional> *myName;
@end
@implementation DSHttpRegisterResultCompany
@end

@protocol DSHttpRegisterResultProvider;
@interface DSHttpRegisterResultProvider:JSONModel
@property NSArray<DSHttpRegisterResultCompany>*companies;
@property NSString<Optional> *activeCompanyName;
@end
@implementation DSHttpRegisterResultProvider
@end

@protocol DSHttpRegisterResultPersonInfo;
@interface DSHttpRegisterResultPersonInfo : JSONModel
@property NSString<Optional> *id;
@property NSString<Optional> *avatar;
@property NSString<Optional> *name;
@property NSString<Optional> *role;
@property NSString<Optional> *authorized;
@property NSString<Optional> *InstitutionCreator;
@property DSHttpRegisterResultIndividual<Optional>*Individual;
@property DSHttpRegisterResultProvider<Optional>*provider;     //???
@property NSString<Optional> *login;
@property NSString<Optional> *institution;
@property NSString<Optional> *institutioner;
@property NSString<Optional> *park;
@end
@implementation DSHttpRegisterResultPersonInfo
@end

@interface DSHttpRegisterResultData : JSONModel
@property DSHttpRegisterResultAccessToken<Optional>*accesstoken;
@property DSHttpRegisterResultPersonInfo<Optional>*personInfo;

@end
@implementation DSHttpRegisterResultData
@end

@interface DSHttpRegisterResult()
@property DSHttpRegisterResultData *data;
@end

@implementation DSHttpRegisterCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpRegisterResult *result = (DSHttpRegisterResult *)self.result;
    if (code > 199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpRegisterResultData alloc] initWithDictionary:dic error:(NSError **)&error];
        
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

@implementation DSHttpRegisterResult

- (NSString *)getAccessToken{
    return self.data.accesstoken.access_token;
}

- (NSString *)getId{
    return self.data.personInfo.id;
}

- (NSString *)getAvatar{
    return self.data.personInfo.avatar;
}

- (NSString *)getName{
    return self.data.personInfo.name;
}

- (NSString *)getRole{
    return self.data.personInfo.role;
}

- (NSString *)getIsAuthorized{
    return self.data.personInfo.authorized;
}

- (NSString *)getPhone{
    return self.data.personInfo.login;
}

@end
