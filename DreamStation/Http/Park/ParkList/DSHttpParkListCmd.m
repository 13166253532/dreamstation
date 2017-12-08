//
//  DSHttpParkListCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/22.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpParkListCmd.h"
#import "DSHttpParkListResult.h"
static NSString *kActionUrl = @"/accounts/park";
@implementation DSHttpParkListCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpParkListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpParkListResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    NSString *url = [NSString stringWithFormat:@"%@?page=%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_ParkList_page]];
    return url;
}

@end
NSString *const kHttpParamKey_ParkList_page = @"page";
NSString *const kHttpParamKey_ParkList_size = @"size";
 NSString *const kHttpParamKey_ParkList_park = @"park";