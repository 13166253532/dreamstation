//
//  SMCommandComplete.m
//  HttpExamples
//
//  Created by wei wu on 14-8-25.
//  Copyright (c) 2014年 misapprehand. All rights reserved.
//

#import "SMCommandComplete.h"
#import "SMBaseHttpComplete.h"
#import "SMUnitTestMacroDef.h"
#import "RequestResult.h"

@interface SMCommandComplete()
@property SMBaseHttpComplete *complete;
@end
@implementation SMCommandComplete

-(id)init
{
    self = [super init];
    
    if(self){
    }
    return self;
}

-(void)waitForComplete{
    StartBlock();
    self.complete = [[SMBaseHttpComplete alloc] initWithBlock:^(RequestResult *result,id userInfo){
        EndBlock();
    }  withUserInfo:nil];    
    WaitUntilBlockCompletes();
}

-(void)complete:(id)resultObj{
    [self.complete complete:nil];
}
@end
