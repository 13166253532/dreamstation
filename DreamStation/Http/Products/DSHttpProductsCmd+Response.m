//
//  DSHttpProductsCmd+Response.m
//  DreamStation
//
//  Created by QPP on 16/8/5.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpProductsCmd+Response.h"
#import "DSHttpProductsResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpProductsResultCategories;
@interface DSHttpProductsResultCategories : JSONModel
@property NSString<Optional> *description;
@property NSString<Optional> *name;
@end
@implementation DSHttpProductsResultCategories
@synthesize description;
@end


@protocol DSHttpProductsResultDetail;
@interface DSHttpProductsResultDetail : JSONModel
/**项目id**/
@property NSString<Optional> *id;
/**公司名称**/
@property NSString<Optional> *companyName;
/**执照url**/
@property NSString<Optional> *licenceUrl;
/**公司地址**/
@property NSString<Optional> *address;
/**用户姓名**/
@property NSString<Optional> *myName;
/**官网**/
@property NSString<Optional> *homePage;
/**微信公众号*/
@property NSString<Optional> *wxPublicAccount;
/**名片地址*/
@property NSString<Optional> *cardUrl;
/**职位*/
@property NSString<Optional> *position;
/**个人邮箱*/
@property NSString<Optional> *email;
/**微信号*/
@property NSString<Optional> *wxAccount;
/**linkedIn账号*/
@property NSString<Optional> *linkedIn;
/**是否上过节目*/
@property NSString<Optional> *hasShow;
/**融资金额*/
@property NSString<Optional> *amount;
/**占股比*/
@property NSString<Optional> *ratio;
/**一句话标题*/
@property NSString<Optional> *brief;
/**视频链接*/
@property NSString<Optional> *videoUrl;
/**是否需要更多服务**/
@property NSString<Optional> *needMoreService;
/**是否希望上节目**/
@property NSString<Optional> *needShow;
/**是否进孵化器**/
@property NSString<Optional> *needIncubator;
/**投资亮点**/
@property NSString<Optional> *highLight;
/**行业**/
@property NSString<Optional> *market;
/**商业模式**/
@property NSString<Optional> *businessMode;
/**产品或服务优势**/
@property NSString<Optional> *advantages;
/**商业计划书**/
@property NSString<Optional> *businessPlan;
/**是否深度推荐**/
@property NSString<Optional> *depthRecommend;
/****/
@property NSArray<Optional> *cats;
/****/
@property NSString<Optional> *interviewNum;
/****/
@property NSString<Optional> *createTime;
@property NSMutableArray<DSHttpProductsResultCategories> *categories;
@end
@implementation DSHttpProductsResultDetail
@end


@interface DSHttpProductsResultContent : JSONModel
@property NSMutableArray<DSHttpProductsResultDetail> *content;
@end
@implementation DSHttpProductsResultContent
@end


@interface DSHttpProductsResult ()
@property DSHttpProductsResultContent *data;
@end


@implementation DSHttpProductsCmd (Response)
- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpProductsResult *result = (DSHttpProductsResult *)self.result;
    if (code >199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpProductsResultContent alloc]initWithDictionary:dic error:(NSError **)&error];
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


@implementation DSHttpProductsResult

-(NSMutableArray *)getAllContent{
    NSMutableArray *arr=[NSMutableArray array];
    for(int i=0;i<self.data.content.count;i++){
        
        DSProductsInfo *info=[[DSProductsInfo alloc]init];
        DSHttpProductsResultDetail *webInfo=self.data.content[i];
        info.brief = webInfo.brief;
        info.videoUrl = webInfo.videoUrl;
        for (int j=0; j<webInfo.categories.count; j++) {
            DSHttpProductsResultCategories *CatInfo=webInfo.categories[j];
            DSProductsCategoriesInfo * Categories = [[DSProductsCategoriesInfo alloc]init];
            Categories.name = CatInfo.name;
            Categories.descriptio = CatInfo.description;
            [info.categoriesList addObject:Categories];
        }
        info.needShow = webInfo.needShow;
        info.needIncubator = webInfo.needIncubator;
        info.depthRecommend = webInfo.depthRecommend;
        info.id=webInfo.id;
        info.companyName = webInfo.companyName;
        info.licenceUrl = webInfo.licenceUrl;
        info.address = webInfo.address;
        info.myName = webInfo.myName;
        info.homePage = webInfo.homePage;
        info.wxPublicAccount = webInfo.wxPublicAccount;
        info.cardUrl = webInfo.cardUrl;
        info.position = webInfo.position;
        info.email = webInfo.email;
        info.wxAccount = webInfo.wxAccount;
        info.linkedIn = webInfo.linkedIn;
        info.hasShow = webInfo.hasShow;
        info.amount = webInfo.amount;
        info.ratio = webInfo.ratio;
        info.brief = webInfo.brief;
        info.videoUrl = webInfo.videoUrl;
        info.needMoreService = webInfo.needMoreService;
        info.needShow = webInfo.needShow;
        info.needIncubator = webInfo.needIncubator;
        info.highLight = webInfo.highLight;
        info.market = webInfo.market;
        info.businessMode = webInfo.businessMode;
        info.advantages = webInfo.advantages;
        info.businessPlan = webInfo.businessPlan;
        info.depthRecommend = webInfo.depthRecommend;
        if (webInfo.interviewNum == nil) {
            info.interviewNum = @"0";
        }else{
            info.interviewNum = webInfo.interviewNum;
        }
        info.createTime = webInfo.createTime;
        [arr addObject:info];
    }
    return arr;
}

@end
