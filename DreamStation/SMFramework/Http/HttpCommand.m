//
//  HttpCommad.m
//  HttpExamples
//
//  Created by wei wu on 14-7-18.
//  Copyright (c) 2014年 www.smilingmobile.com. All rights reserved.
//

#import "HttpCommand.h"
#import "RequestResult.h"
#import "HttpConfig.h"
#import "HttpConfigGroup.h"

@interface HttpCommand (priv)
-(void)ThrowOverridException;
//@property NSString *version;
@end
@implementation HttpCommand
@synthesize requestInfo = requestInfo_;
@synthesize result = result_;

+(HttpCommand *) addHttpCommandWithVersion:(NSString *)version{
    return nil;
}


+(HttpCommand *) httpCommandWithVersion:(NSString *)version
{
    NSAssert(NO, @"must implement in subclass!");
    return nil;
}

-(void)ThrowOverridException
{
   @throw [NSException exceptionWithName:NSInternalInconsistencyException
                       reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                       userInfo:nil];
}


#pragma mark - Public function
- (id)init{
    self = [super init];
    
    if(self){
    }
    return self;
}
-(instancetype)initWithVersion:(NSString *)version
{
    self = [super init];
    if (nil != self) {
        self.version = version;
        _needVerify = NO;
    }
    return self;
}



-(instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self=[super init];
    if (self){
        _authorState=state;
    }
    
    return  self;
}


-(instancetype)initWithVerify:(BOOL)needVerify
{
    self = [super init];
    
    if(self){
        _needVerify = needVerify;
    }
    return self;
}


-(instancetype)initWithOtherParamsNeed:(BOOL)needOtherParams
{
    self = [super init];
    
    if(self){
        _needOtherParams = needOtherParams;
    }
    return self;
}

-(instancetype)initWithVerify:(BOOL)needVerify withOtherParamsNeed:(BOOL)needOtherParams
{
    self = [super init];
    
    if(self){
        _needVerify = needVerify;
        _needOtherParams = needOtherParams;
    }
    return self;
}

-(void)invokeComplete{
    if (NULL != [self completeDelegate]){
        [[self completeDelegate] complete:[self result]];
    }
}
-(NSString *)getBaseUrl
{
    //[self ThrowOverridException];
    HttpConfig *config = [HttpConfigGroup getCurrentConfig];
    return (NSString *)[config getServerAddress:nil];
    //return nil;
}
-(NSString *)getActionUrl{
	[self ThrowOverridException];
    return nil;
}
-(NSDictionary *)getRequestParam{
	[self ThrowOverridException];
	return nil;
}
#pragma mark - Override
-(id)execute
{
   return [self.delegate execute];
}
-(void)cancel
{
   [self.delegate cancel];
}

-(NSString *)getUrl
{
    NSURL *url = [NSURL URLWithString:[self getActionUrl]
                         relativeToURL:[NSURL URLWithString:[self getBaseUrl]]];
    return [url absoluteString];
    
}

-(id)getResult
{
   return [self result];
}
- (void)onRequestSuccess:(id)request code:(NSInteger)code
{
    [self ThrowOverridException];
	//[self onRequestSuccess:request];
}
- (void)onRequestFailed:(id)request
{
    [self ThrowOverridException];
	//[self onRequestFailed:request];
}

@end
