//
//  DSHttpPerProductsCmd+Response.m
//  DreamStation
//
//  Created by xjb on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpPerProductsCmd+Response.h"
#import "DSHttpPerProductsResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"


@protocol DSHttpPerProductsResultCategories;
@interface DSHttpPerProductsResultCategories : JSONModel
@property NSString<Optional> *description;
@property NSString<Optional> *name;
@end
@implementation DSHttpPerProductsResultCategories
@synthesize description;
@end


@protocol DSHttpPerProductsResultDetail;
@interface DSHttpPerProductsResultDetail : JSONModel
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

@property NSString<Optional> *productStatus;
/****/
@property NSArray<Optional> *cats;
@property NSMutableArray<DSHttpPerProductsResultCategories> *categories;
@end
@implementation DSHttpPerProductsResultDetail
@end


@interface DSHttpPerProductsResultContent : JSONModel
@property NSMutableArray<DSHttpPerProductsResultDetail> *content;
@end
@implementation DSHttpPerProductsResultContent
@end


@interface DSHttpPerProductsResult ()
@property DSHttpPerProductsResultContent *data;
@end




@implementation DSHttpPerProductsCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpPerProductsResult *result = (DSHttpPerProductsResult *)self.result;
    if (code >199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpPerProductsResultContent alloc]initWithDictionary:dic error:(NSError **)&error];
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



@implementation DSHttpPerProductsResult

- (NSMutableArray *)getAllContent{
    NSMutableArray *arr=[NSMutableArray array];
    for(int i=0;i<self.data.content.count;i++){
        
        DSProductsInfo *info=[[DSProductsInfo alloc]init];
        DSHttpPerProductsResultDetail *webInfo=self.data.content[i];
        info.brief = webInfo.brief;
        info.videoUrl = webInfo.videoUrl;
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
        info.productStatus = webInfo.productStatus;
        info.depthRecommend = webInfo.depthRecommend;
        for (int j=0; j<webInfo.categories.count; j++) {
            DSHttpPerProductsResultCategories *catInfo = [[DSHttpPerProductsResultCategories alloc]init];
            catInfo = webInfo.categories[j];
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            dic[@"catName"]= catInfo.name;
            dic[@"description"] = catInfo.description;
            [info.catList addObject:dic];
        }
        NSData *data=[NSJSONSerialization dataWithJSONObject:info.catList options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        info.jsonCat = [self getStr:jsonString];
        [arr addObject:info];
    }
    return arr;
}
- (NSString *)getStr:(NSString *)str{
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str2;
}

@end
