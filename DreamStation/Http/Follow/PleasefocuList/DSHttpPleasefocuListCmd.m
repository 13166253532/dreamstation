//
//  DSHttpPleasefocuListCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/25.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPleasefocuListCmd.h"
#import "DSHttpPleasefocuListResult.h"

static NSString *kActionUrl = @"/follow/follow";
@implementation DSHttpPleasefocuListCmd


+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpPleasefocuListCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpPleasefocuListResult alloc]init];
    }
    return self;
}
- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_PleasefocuList_page]];
    return url;
}
//- (NSString *)getActionUrl{
//    NSString *url = [NSString stringWithFormat:@"%@",kActionUrl];
//    return url;
//}

@end
NSString * const kHttpParamKey_PleasefocuList_page = @"page";
NSString * const kHttpParamKey_PleasefocuList_size = @"size";
NSString * const kHttpParamKey_PleasefocuList_individualId = @"individualId";
NSString * const kHttpParamKey_PleasefocuList_institutionId = @"institutionId";
