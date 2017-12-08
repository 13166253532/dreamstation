//
//  SMBaseHttpComplete.m
//  HttpExamples
//
//  Created by wei wu on 14-9-2.
//  Copyright (c) 2014年 misapprehand. All rights reserved.
//

#import "SMBaseHttpComplete.h"

@interface SMBaseHttpComplete()
@property id userInfo;
@end
@implementation SMBaseHttpComplete

-(id) initWithBlock:(void(^)(RequestResult *,id))completeBlock withUserInfo:(id)userInfo{
    self = [super init];
    
    if(self){
        _completeBlock = completeBlock;
        _userInfo = userInfo;
    }
    return self;
}

#pragma mark - Overrided

-(void)complete:(id)resultObj{
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:resultObj waitUntilDone:YES];
}
-(void)updateUI:(RequestResult *)result
{
	[self completeBlock]((RequestResult *)result,_userInfo);
}
@end

