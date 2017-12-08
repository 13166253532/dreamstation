//
//  DSHttpIsCollectionsCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/11.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpIsCollectionsCmd.h"
#import "DSHttpIsCollectionsResult.h"
static NSString *kActionUrl = @"/collections/status";
@implementation DSHttpIsCollectionsCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpIsCollectionsCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpIsCollectionsResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    if ([self.requestInfo objectForKey:kHttpParamKey_IsCollections_groupId] != nil) {
        kActionUrl = [NSString stringWithFormat:@"/collections/status?%@/%@/%@",[self.requestInfo objectForKey:kHttpParamKey_IsCollections_groupId],[self.requestInfo objectForKey:kHttpParamKey_IsCollections_collections],[self.requestInfo objectForKey:kHttpParamKey_IsCollections_type]];
    }else{
        kActionUrl = [NSString stringWithFormat:@"/collections/status?%@/%@",[self.requestInfo objectForKey:kHttpParamKey_IsCollections_collections],[self.requestInfo objectForKey:kHttpParamKey_IsCollections_type]];
    }
    return kActionUrl;
}



@end
NSString *const kHttpParamKey_IsCollections_groupId = @"groupId";
NSString *const kHttpParamKey_IsCollections_collections = @"collections";
NSString *const kHttpParamKey_IsCollections_type = @"type";