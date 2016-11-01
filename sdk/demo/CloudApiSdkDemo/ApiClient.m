//
//  Demo.m
//  CloudApiSdkDemo
//
//  Created by  fred on 2016/10/26.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "ApiClient.h"
#import <CloudApiSdk/HttpConstant.h>

@implementation ApiClient

static NSString* HOST = @"";

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static ApiClient *api = nil;
    dispatch_once(&onceToken, ^{
        api = [ApiClient new];
    });
    return api;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[AppConfiguration instance] setAPP_KEY:@""];
        [[AppConfiguration instance] setAPP_SECRET:@""];
    }
    return self;
}

- (void) sendHttpGetDemo:(NSInteger) userId
                     sex:(NSString *) sex
                     age:(NSInteger) age
         completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock
{
    
    //定义Path
    NSString * path = @"/v3/getUserTest/[userId]";
    
    //定义PathParameter
    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    [pathParams setValue:[NSString stringWithFormat:@"%ld" , userId] forKey:@"userId"];
    
    //定义QueryParameter
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    [queryParams setValue:sex forKey:@"sex"];
    
    //定义HeaderParameter
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setValue:[NSString stringWithFormat:@"%ld" , age] forKey:@"age"];
    
    [[CloudApiSdk instance] httpGet: CLOUDAPI_HTTP
                               host: HOST
                               path: path
                         pathParams: pathParams
                        queryParams: queryParams
                       headerParams: headerParams
                    completionBlock: completionBlock];
    
}

- (void) sendHttpPostFormDemo:(NSInteger) userId
                          sex:(NSString *) sex
                          age:(NSInteger) age
              completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock
{
    //定义Path
    NSString * path = @"/testhttp/postform";
    
    //定义QueryParameter
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    [queryParams setValue:sex forKey:@"sex"];
    
    //定义HeaderParameter
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setValue:[NSString stringWithFormat:@"%ld" , age] forKey:@"TestPostHeader"];
    
    //定义HeaderParameter
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    [formParams setValue:[NSString stringWithFormat:@"%ld" , userId] forKey:@"TestAccount"];
    
    [[CloudApiSdk instance] httpPost: CLOUDAPI_HTTP
                                host: HOST
                                path: path
                          pathParams: nil
                         queryParams: queryParams
                          formParams: formParams
                        headerParams: headerParams
                     completionBlock: completionBlock];

}


- (void) sendHttpPostBytesDemo:(NSInteger) userId
                           age:(NSInteger) age
                          sign:(NSString *) sign
               completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock
{
    
    //定义Path
    NSString * path = @"/testhttp/postbyte";
    
    //定义QueryParameter
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    [queryParams setValue:[NSString stringWithFormat:@"%ld" , userId] forKey:@"QueryName"];
    
    //定义HeaderParameter
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setValue:[NSString stringWithFormat:@"%ld" , age] forKey:@"TestPostHeader"];
    
    NSData * body = [sign dataUsingEncoding:NSUTF8StringEncoding];
    
    [[CloudApiSdk instance] httpPost: CLOUDAPI_HTTP
                                host: HOST
                                path: path
                          pathParams: nil
                         queryParams: queryParams
                                body: body
                        headerParams: headerParams
                     completionBlock: completionBlock];
}


- (void) sendHttpPutBytesDemo:(NSInteger) userId
                          age:(NSInteger) age
                         sign:(NSString *) sign
              completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock
{
    //定义Path
    NSString * path = @"/testhttp/putform";
    
    //定义QueryParameter
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    [queryParams setValue:[NSString stringWithFormat:@"%ld" , userId] forKey:@"QueryName"];
    
    //定义HeaderParameter
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setValue:[NSString stringWithFormat:@"%ld" , age] forKey:@"TestPostHeader"];
    
    NSData * body = [sign dataUsingEncoding:NSUTF8StringEncoding];
    
    [[CloudApiSdk instance] httpPut: CLOUDAPI_HTTP
                               host: HOST
                               path: path
                         pathParams: nil
                        queryParams: queryParams
                               body: body
                       headerParams: headerParams
                    completionBlock: completionBlock];
}

- (void) sendHttpDeleteDemo:(NSInteger) userId
                        age:(NSInteger) age
            completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock
{
    //定义Path
    NSString * path = @"/testhttp/delete";
    
    //定义QueryParameter
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    [queryParams setValue:[NSString stringWithFormat:@"%ld" , userId] forKey:@"QueryName"];
    
    //定义HeaderParameter
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setValue:[NSString stringWithFormat:@"%ld" , age] forKey:@"TestPostHeader"];
    
    [[CloudApiSdk instance] httpDelete: CLOUDAPI_HTTP
                                  host: HOST
                                  path: path
                            pathParams: nil
                           queryParams: queryParams
                          headerParams: headerParams
                       completionBlock: completionBlock];
}
@end
