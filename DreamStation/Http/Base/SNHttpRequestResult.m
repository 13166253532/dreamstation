//
//  QSHttpRequestResult.m
//  QiuShi
//
//  Created by wei wu on 14-9-26.
//  Copyright (c) 2014年 wei wu. All rights reserved.
//

#import "SNHttpRequestResult.h"

#import "HTHttpConfig.h"
#import "HttpConfigGroup.h"


#define SUCCESS (@"00000000")

NSString * const CODE_TOKEN_PAST = @"00100002";
NSString * const CODE_TOKEN_ERROR_MACTH = @"00100004";
NSString * const CODE_NEED_LOGIN_IN = @"00100006";
//00010002//token time out
//00010004//token not macth
static const NSString *kStatusCode = @"code";
static const NSString *kMsg = @"memo";

@interface SNHttpRequestResult ()//<UIAlertViewDelegate>

@end
@implementation SNHttpRequestResult
-(BOOL)parseBasicInfo:(NSDictionary *)response code:(NSInteger)code{

    NSString *memo = [response objectForKey:@"error_description"];

    if (code > 199&&code < 300) {
        [self setResultState:kRequestResultSuccess];
        return YES;
    }else{
        [self setResultState:kRequestResultFail];
        [self setErrMsg:memo];
        NSLog(@"code :%ld errormsg:%@",(long)code,memo);
        return NO;
    }
//        if ([responseCode isEqualToString:SUCCESS]) {
//            [self setResultState:kRequestResultSuccess];
//            return YES;
//        }else if([responseCode isEqualToString:CODE_TOKEN_ERROR_MACTH]){
//            [self setResultState:kRequestResultFail];
//            [self setErrMsg:[response objectForKey:kMsg]];
//            [self setErrCode:[response objectForKey:kStatusCode]];
//            self.accessTokenValid = NO;
////            [[SNAccountData sharedInstance] saveLoginState:NO];
//            [self showAlertPastTokenForLogin];
//            return NO;
//        }else if([responseCode isEqualToString:CODE_NEED_LOGIN_IN]){
//            [self setResultState:kRequestResultFail];
//            [self setErrMsg:[response objectForKey:kMsg]];
//            [self setErrCode:[response objectForKey:kStatusCode]];
//            self.accessTokenValid = NO;
////            [[SNAccountData sharedInstance] saveLoginState:NO];
//            [self showLoginVC];
//            return NO;
//        }
//        else{
//            [self setResultState:kRequestResultFail];
//            [self setErrMsg:[response objectForKey:kMsg]];
//            [self setErrCode:[response objectForKey:kStatusCode]];
//            NSLog(@"memo = %@", [self errMsg]);
//            return NO;
//        }
}
-(HttpConfig *)httpConfig
{
    return [[HttpConfigGroup sharedInstance] getHttpConfig:[HTHttpConfig registerKey]];
}


//-(NSString *)getDefaultImageUrl:(NSString *)imageName{
//    HttpConfig *config = [self httpConfig];
//    NSAssert(nil != config,@"Must init http config");
//    NSString const *serverAddress =  [config getServerAddress:kDefault_server_image_key];
//    
//    return [NSString stringWithFormat:@"%@/upload/%@",serverAddress,imageName];
//}

#pragma --nsdictory to json

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

-(void)showAlertPastTokenForLogin
{
//    SNAppDelegate * delegate = [UIApplication sharedApplication].delegate;
//    [delegate accessTokenPastToLogin:self.loginCompleteBlock];
}

-(void)showLoginVC
{
//    SNAppDelegate * delegate = [UIApplication sharedApplication].delegate;
//    [delegate showToLogin:self.loginCompleteBlock];
//    [delegate accessTokenPastToLogin:self.loginCompleteBlock];
}

@end
