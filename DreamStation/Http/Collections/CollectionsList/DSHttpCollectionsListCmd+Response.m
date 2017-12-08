//
//  DSHttpCollectionsListCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/8.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpCollectionsListCmd+Response.h"
#import "DSHttpCollectionListResule.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"


@protocol DSHttpCollectionsContentResuleDetail;
@interface DSHttpCollectionsContentResuleDetail : JSONModel
@property NSString<Optional> *videoUrl;
@property NSString<Optional> *titleName;
@property NSString<Optional> *level;
@property NSString<Optional> *typeTag;
@property NSString<Optional> *iconUrl;
@property NSString<Optional> *videoPicUrl;
@property NSString<Optional> *videoTitle;
@property NSString<Optional> *favoriteNotes;
@end
@implementation DSHttpCollectionsContentResuleDetail
@end



@protocol DSHttpCollectionListResuleDetail;
@interface DSHttpCollectionListResuleDetail : JSONModel
@property NSString<Optional> *userId;
@property NSString<Optional> *id;
@property NSString<Optional> *collections;
@property NSString<Optional> *collectionsContent;
@property NSString<Optional> *collectionsType;
@property NSString<Optional> *userGroupId;
@property NSString<Optional> *username;
@property NSString<Optional> *mark;
@end
@implementation DSHttpCollectionListResuleDetail
@end


@interface DSHttpCollectionListContent : JSONModel
@property NSMutableArray<DSHttpCollectionListResuleDetail> *content;
@property NSString<Optional> *number;
@property NSString<Optional> *sort;
@property NSString<Optional> *numberOfElements;
@property NSString<Optional> *totalPages;
@property NSString<Optional> *size;
@property NSString<Optional> *last;
@property NSString<Optional> *totalElements;
@property NSString<Optional> *first;
@end
@implementation DSHttpCollectionListContent
@end
@interface DSHttpCollectionListResule ()
@property DSHttpCollectionListContent *data;
@end
@implementation DSHttpCollectionsListCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpCollectionListResule *result = (DSHttpCollectionListResule *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpCollectionListContent alloc]initWithDictionary:dic error:(NSError **)&error];
        
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
@implementation DSHttpCollectionListResule
-(NSMutableArray *)getTheContent{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.data.content.count; i++) {
        DSHttpCollectionsListInfo *info = [[DSHttpCollectionsListInfo alloc]init];
        DSHttpCollectionListResuleDetail *resuleDetail = self.data.content[i];
        info.userId = resuleDetail.userId;
        info.id = resuleDetail.id;
        info.collections = resuleDetail.collections;
        info.mark = resuleDetail.mark;
        //info.collectionsContent = resuleDetail.collectionsContent;
//        aa.collectionsContent.removeAtIndex(aa.collectionsContent.startIndex.advancedBy(0))
//        aa.collectionsContent.removeAtIndex(aa.collectionsContent.startIndex.advancedBy(aa.collectionsContent.characters.count-1))
//        print(aa.collectionsContent)
//        let data = aa.collectionsContent.dataUsingEncoding(NSUTF8StringEncoding)
//        let sss = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
        NSData *data = [resuleDetail.collectionsContent dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        DSHttpCollectionsContentResuleDetail *result = [[DSHttpCollectionsContentResuleDetail alloc]initWithDictionary:dic error:nil];
        info.titleName = result.titleName;
        info.videoUrl = result.videoUrl;
        info.level = result.level;
        
        if ([result.typeTag containsString:@"["]) {
            NSData *datas = [result.typeTag dataUsingEncoding:NSUTF8StringEncoding];
            info.typeTag = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
        }
        info.favoriteNotes = result.favoriteNotes;
        info.videoTitle = result.videoTitle;
        info.iconUrl = result.iconUrl;
        info.videoPicUrl = result.videoPicUrl;
        
        info.collectionsType = resuleDetail.collectionsType;
        info.userGroupId = resuleDetail.userGroupId;
        info.username = resuleDetail.username;
        [arr addObject:info];
    }
    return arr;
}
- (NSString *)getThesize{
    return self.data.size;
}

@end
