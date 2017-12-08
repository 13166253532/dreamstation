//
//  DSHttpCollectionDeleteCmd.m
//  DreamStation
//
//  Created by QPP on 16/8/10.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpCollectionDeleteCmd.h"
#import "DSHttpCollectionDeleteResult.h"

static NSString *kActionUrl = @"/collections/";
@implementation DSHttpCollectionDeleteCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpCollectionDeleteCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpCollectionDeleteResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    
    NSString *str=[NSString stringWithFormat:@"%@%@",kActionUrl,[self.requestInfo objectForKey:kHttpParamKey_Collection_collectionId]];
    return str;
}

@end
NSString *const kHttpParamKey_Collection_collectionId=@"id";
