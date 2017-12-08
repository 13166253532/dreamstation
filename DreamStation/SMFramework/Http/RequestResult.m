//
//  RequestResult.m
//  HttpExamples
//
//  Created by wei wu on 14-7-17.
//  Copyright (c) 2014年 www.smilingmobile.com. All rights reserved.
//

#import "RequestResult.h"

NSString const *kRequestResultKey_State=@"status";
@interface RequestResult()

@property BOOL tokenValid;
@end



@implementation RequestResult
-(id)init{
    self = [super init];
    if (nil != self) {
        _tokenValid = YES;
    }
    return self;
}
-(bool) isOk{
    return (kRequestResultSuccess == [self resultState]);
}
-(BOOL) accessTokenValid{
    return self.tokenValid;
}
-(void) setAccessTokenValid:(BOOL)accessTokenValid{
    self.tokenValid = accessTokenValid;
}
@end
