//
//  DSHttpCollectionCmd.h
//  DreamStation
//
//  Created by xjb on 16/8/9.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "SNHttpBasePostCmd.h"

@interface DSHttpCollectionCmd : SNHttpBasePostCmd
+ (HttpCommand *)httpCommandWithVersion:(NSString *)version;
@end
extern NSString *const kHttpParamKey_Collection_userGroupId;
extern NSString *const kHttpParamKey_Collection_collections;
extern NSString *const kHttpParamKey_Collection_collectionsType;
extern NSString *const kHttpParamKey_Collection_username;

extern NSString *const kHttpParamKey_Collection_collectionsContent;
extern NSString *const kHttpParamKey_Collection_collectionsContent_id;
extern NSString *const kHttpParamKey_Collection_collectionsContent_titleName;
extern NSString *const kHttpParamKey_Collection_collectionsContent_typeTag;
extern NSString *const kHttpParamKey_Collection_collectionsContent_videoUrl;
extern NSString *const kHttpParamKey_Collection_collectionsContent_favoriteNotes;
extern NSString *const kHttpParamKey_Collection_collectionsContent_level;
extern NSString *const kHttpParamKey_Collection_collectionsContent_iconUrl;
extern NSString *const kHttpParamKey_Collection_collectionsContent_videoPicUrl;
extern NSString *const kHttpParamKey_Collection_collectionsContent_videoTitle;
extern NSString *const kHttpParamKey_Collection_mark;