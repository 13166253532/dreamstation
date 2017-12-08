//
//  DSHttpInstitutionersPerListCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpInstitutionersPerListCmd.h"
#import "DSHttpInstitutionersPerListResult.h"
static NSString *kActionUrl;
@implementation DSHttpInstitutionersPerListCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpInstitutionersPerListCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}
- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpInstitutionersPerListResult alloc]init];
    }
    return self;
}
- (NSString *)getActionUrl{
    kActionUrl = [NSString stringWithFormat:@"/accounts/institutions/%@/institutioners",[self.requestInfo objectForKey:kHttpParamKey_InstitutionersPerList_institutionId]];
    
    return kActionUrl;
}
@end
NSString *const kHttpParamKey_InstitutionersPerList_institutionId = @"institutionId";
NSString *const kHttpParamKey_InstitutionersPerList_page = @"page";
NSString *const kHttpParamKey_InstitutionersPerList_size = @"size";