//
//  HTShareSDKTool.m
//  HiTeacher
//
//  Created by QPP on 16/6/21.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "HTShareSDKTool.h"

#import "WXApi.h"
#import "WeiboSDK.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#define kShareSDK_KEY  @"16b04b6432fc4"
#define kWBAPP_ID @"3044077614"
#define kWBAPP_SECRECT @"73b4f67a645a9f3e3fc0cee5f6959814"
#define kWBAPP_REDIRECTURI @"http://www.sharesdk.cn"


#define kWXAPP_ID      @"wxdea806a2920acb34"
#define kWXAPP_SECRET  @"ff35909c176c751d07aacf19136f68e9"


@implementation HTShareSDKTool

+ (HTShareSDKTool *)sharedShareSDKTool{
    static HTShareSDKTool *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedInstance = [[HTShareSDKTool alloc] init];
    });
    return sharedInstance;
}

-(BOOL)checkWXClient
{
    if (![WXApi isWXAppInstalled]) {
        return NO;
    }
    if (![WXApi isWXAppSupportApi]) {
        return NO;
    }
    return YES;
}

- (void)registerApp{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    
    [ShareSDK registerApp:kShareSDK_KEY activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformSubTypeWechatSession:
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:kWXAPP_ID appSecret:kWXAPP_SECRET];
                      break;
                  case SSDKPlatformTypeSinaWeibo:
                      [appInfo SSDKSetupSinaWeiboByAppKey:kWBAPP_ID appSecret:kWBAPP_SECRECT redirectUri:kWBAPP_REDIRECTURI authType:SSDKAuthTypeBoth];
                      break;
                  default:break;
              }
          }];
}

-(void)shareForPlat:(SSDKPlatformType)plat shareParams:(NSMutableDictionary*)shareParams successBlock:(void(^)())successBlock failBlock:(void(^)())failBlock cancleBlock:(void(^)())cancleBlock
{
    //进行分享
    [ShareSDK share:plat
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 successBlock();
                 break;
             }
             case SSDKResponseStateFail:
             {
                 failBlock();
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 cancleBlock();
                 break;
             }
             default:
                 break;
         }
     }];
}

- (void)shareForPlat:(NSString *)url withImage:(NSString *)image withTitle:(NSString *)title{
    
    //UIImage *img = [UIImage imageNamed:image];
    UIImage *shareImage = [UIImage imageNamed:@"homePage_share"];
    NSArray *imageArray = @[shareImage];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
   
    NSString *content = title;
    NSString *string = [content stringByAppendingFormat:@"%@",url];
    [shareParams SSDKSetupShareParamsByText:string
                                     images:imageArray
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    
    [ShareSDK showShareActionSheet:nil
                             items:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeWechatSession)]
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           
                           
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
                   
               }
     ];


}

#pragma mark ---微博一键分享
- (void)shareForSina:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)pageUrl{

    //需求有变
    NSURL *imageUrl = [NSURL URLWithString:image];
    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    //UIImage *shareImage = [UIImage imageNamed:@"homePage_share"];
    
    NSMutableDictionary *shareParamDic = [NSMutableDictionary dictionary];
    [shareParamDic SSDKEnableUseClientShare];
    
    NSString *textContent = [title stringByAppendingString:pageUrl];
    
    [shareParamDic SSDKSetupShareParamsByText:textContent images:shareImage url:[NSURL URLWithString:pageUrl] title:title type:SSDKContentTypeAuto];
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeSinaWeibo] != YES) {
        [ShareSDK showShareEditor:SSDKPlatformTypeSinaWeibo otherPlatformTypes:nil shareParams:shareParamDic onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                
                default:
                break;
            }

        }];
    }else{
        [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParamDic onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                
                default:
                break;
            }
        }];

    }
    
    
    
    
    
    
    
}

#pragma mark ---微信一键分享
- (void)shareForWechat:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)pageUrl withContent:(NSString *)contentValue{
    UIImage *shareImage = [[UIImage alloc]init];
    if (image != nil) {
        NSURL *imageUrl = [NSURL URLWithString:image];
        shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    }else{
        shareImage = [UIImage imageNamed:@"homePage_share"];
    }
    
    //图片有变，暂用应用图标来分享

    NSMutableDictionary *shareParamDic = [NSMutableDictionary dictionary];
    
    
//    NSString *textContent = [title stringByAppendingString:contentValue];
    
    [shareParamDic SSDKSetupShareParamsByText:contentValue images:shareImage url:[NSURL URLWithString:pageUrl] title:title type:SSDKContentTypeAuto];
    

    [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParamDic onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
                
            default:
                break;
        }
    }];
}

#pragma mark ---微信朋友圈分享
- (void)shareForMoments:(NSString *)title withImage:(NSString *)image withUrl:(NSString *)pageUrl{
    UIImage *shareImage = [[UIImage alloc]init];
    if (image == nil) {
         shareImage = [UIImage imageNamed:@"homePage_share"];
    }else{
        //需求有变
        NSURL *imageUrl = [NSURL URLWithString:image];
       shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    }
    NSMutableDictionary *shareParamDic = [NSMutableDictionary dictionary];
    
    NSString *textContent = [title stringByAppendingString:pageUrl];
    
    [shareParamDic SSDKSetupShareParamsByText:textContent images:shareImage url:[NSURL URLWithString:pageUrl] title:title type:SSDKContentTypeAuto];
    
    
    [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParamDic onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
                
            default:
                break;
        }
    }];

    
}

- (void)shareForPlatOnWechat:(NSString *)url withImage:(NSString *)image withTitle:(NSString *)title{
    
    UIImage *img = [UIImage imageNamed:image];
    NSArray *imageArray = @[img];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSString *content = title;
    NSString *string = [content stringByAppendingFormat:@"%@",url];
    
    [shareParams SSDKSetupShareParamsByText:string
                                     images:imageArray
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet:nil
                             items:@[@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeWechatSession)]
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                      
                       default:
                           break;
                   }
                   
               }
     ];
    
}

#pragma mark - 原生分享页面
- (void)shareForPlat:(NSString *)url{
    UIImage *img = [UIImage imageNamed:@"homePage_activityImage"];
    NSArray* imageArray = @[img];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSString *title = @"嗨外教";
    NSString *content = @"快来看看我的订单信息";
    
    [shareParams SSDKSetupShareParamsByText:content
                                     images:imageArray
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet:nil
                             items:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat)]
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                 
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {

                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
                   
               }
     ];
}

@end
