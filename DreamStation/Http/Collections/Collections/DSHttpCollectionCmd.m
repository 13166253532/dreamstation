//
//  DSHttpCollectionCmd.m
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpCollectionCmd.h"
#import "DSHttpCollectionResult.h"
static NSString *kActionUrl = @"/collections";

@implementation DSHttpCollectionCmd

+ (HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpCollectionCmd alloc]initWithAuthorizationState:AuthorizationToken];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpCollectionResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}

@end

NSString *const kHttpParamKey_Collection_userGroupId = @"userGroupId";
NSString *const kHttpParamKey_Collection_collections = @"collections";
NSString *const kHttpParamKey_Collection_collectionsType = @"collectionsType";
NSString *const kHttpParamKey_Collection_username = @"username";
NSString *const kHttpParamKey_Collection_mark=@"mark";
NSString *const kHttpParamKey_Collection_collectionsContent=@"collectionsContent";

NSString *const kHttpParamKey_Collection_collectionsContent_id=@"id";
NSString *const kHttpParamKey_Collection_collectionsContent_titleName=@"titleName";
NSString *const kHttpParamKey_Collection_collectionsContent_typeTag=@"typeTag";
NSString *const kHttpParamKey_Collection_collectionsContent_videoUrl=@"videoUrl";
NSString *const kHttpParamKey_Collection_collectionsContent_favoriteNotes=@"favoriteNotes";
NSString *const kHttpParamKey_Collection_collectionsContent_level=@"level";
NSString *const kHttpParamKey_Collection_collectionsContent_iconUrl=@"iconUrl";
NSString *const kHttpParamKey_Collection_collectionsContent_videoPicUrl=@"videoPicUrl";
NSString *const kHttpParamKey_Collection_collectionsContent_videoTitle=@"videoTitle";



