//
//  DSHttpAccountsInstituListCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpAccountsInstituListCmd.h"
#import "DSHttpAccountsInatituListResule.h"
static NSString *kActionUrl = @"/accounts/institutions";
@implementation DSHttpAccountsInstituListCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpAccountsInstituListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpAccountsInatituListResule alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    return [self Url];
}

- (NSString *)Url{
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_page]];
    //NSString *url = [NSString stringWithFormat:@"%@?page=%@&sortType=%@&sortItem=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_page],[self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_sortType],[self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_sortItem]];
    
    if ([self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_query] != nil) {
        url = [NSString stringWithFormat:@"%@&query=%@",url,[self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_query]];
    }
    if ([self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_investMin] != nil
        ) {
        url = [NSString stringWithFormat:@"%@&investMax=%@&investMin=%@",url,[self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_investMax],[self.requestInfo objectForKey:kHttpParamKey_AccountsInstituList_investMin]];
    }
    return url;
}



@end
NSString *const kHttpParamKey_AccountsInstituList_page = @"page";
NSString *const kHttpParamKey_AccountsInstituList_size = @"size";
NSString *const kHttpParamKey_AccountsInstituList_query = @"query";

NSString *const kHttpParamKey_AccountsInstituList_Name = @"name";
NSString *const kHttpParamKey_AccountsInstituList_description = @"description";
NSString *const kHttpParamKey_AccountsInstituList_opertor = @"opertor";
 NSString *const kHttpParamKey_AccountsInstituList_investMin = @"investMin";
 NSString *const kHttpParamKey_AccountsInstituList_investMax = @"investMax";

 NSString *const kHttpParamKey_AccountsInstituList_sortType = @"sortType";
 NSString *const kHttpParamKey_AccountsInstituList_sortItem = @"sortItem";
