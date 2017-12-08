//
//  DSHttpCollectionsListCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpCollectionsListCmd.h"
#import "DSHttpCollectionListResule.h"

static NSString *kActionUrl = @"/collections/";
@implementation DSHttpCollectionsListCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpCollectionsListCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpCollectionListResule alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_CollectionList_page]];
    return url;
}

@end
NSString *const kHttpParamKey_CollectionList_page = @"page";
NSString *const kHttpParamKey_CollectionList_size = @"size";