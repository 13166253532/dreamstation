//
//  DSHttpUploadFileCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/24.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpUploadFileCmd+Response.h"
#import "DSHttpUploadFileResult.h"
#import "JSONModel.h"


@protocol HTHttpUploadFileResultData ;
@interface HTHttpUploadFileResultData : JSONModel
@property NSString<Optional> *access;
@property NSString<Optional> *suffix;
@property NSString<Optional> *uuid;
@end

@implementation HTHttpUploadFileResultData
@end


@interface HTHttpUploadFileResultArr : JSONModel
@property NSMutableArray<Optional,HTHttpUploadFileResultData> *result;
@end
@implementation HTHttpUploadFileResultArr
@end

@interface DSHttpUploadFileResult ()
@property HTHttpUploadFileResultArr *data;
@end
@implementation DSHttpUploadFileCmd (Response)

-(void)onRequestSuccess:(id)responesObject code:(NSInteger)code{
    
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)responesObject;
    
    DSHttpUploadFileResult *result = (DSHttpUploadFileResult *)self.result;
    
    
    if (code > 199&&code<299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        
        result.data = [[HTHttpUploadFileResultArr alloc] initWithDictionary:dic error:(NSError **)&error];
        if (error) {
            [self onRequestFailed:error];
            return;
        }
        
    }else{
  
        [self.result setResultState:kRequestResultFail];
    }
}

- (void)onRequestFailed:(NSError *)error{
    NSLog(@"Error: %@", error);
    [self.result setErrMsg:[error localizedDescription]];
    [self.result setResultState:kRequestResultFail];
}

@end

@implementation DSHttpUploadFileResult
- (NSString *)getAvatarUrl{
    HTHttpUploadFileResultData *data=self.data.result[0];
    return data.access;
}

- (NSString *)getSuffix{
    HTHttpUploadFileResultData *data=self.data.result[0];
    return data.suffix;
}

- (NSString *)getUuid{
    HTHttpUploadFileResultData *data=self.data.result[0];
    return data.uuid;
}

@end
