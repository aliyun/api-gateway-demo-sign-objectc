/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

#import "Demo.h"

/**
 *  API调用示例
 */
@implementation Demo


/**
 *  Http Get调用使用，其中query/header中的值可以中文
 *  注意pathparameter不允许中文
 */
+ (void) sendHttpGetDemo{
    
    //定义Path
    NSString * getPath = @"/v3/getUserTest/[userId]";
    
    //定义PathParameter
    NSMutableDictionary *getPathParams = [[NSMutableDictionary alloc] init];
    [getPathParams setValue:@"10000003" forKey:@"userId"];
    
    //定义QueryParameter
    NSMutableDictionary *getQueryParams = [[NSMutableDictionary alloc] init];
    [getQueryParams setValue:@"男" forKey:@"sex"];
    
    //定义HeaderParameter
    NSMutableDictionary *getHeaderParams = [[NSMutableDictionary alloc] init];
    [getHeaderParams setValue:@"18" forKey:@"age"];
    
    //调用HttpUtil.httpGet方法，构造并发送Request对象
    [[HttpUtil instance] httpGet:getPath
                      pathParams:getPathParams
                     queryParams:getQueryParams
                    headerParams:getHeaderParams
     //回调
                 completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                 		  //打印应答对象
                     NSLog(@"Response object: %@" , response);
                     NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                     
                     //打印应答中的body
                     NSLog(@"Response body: %@" , bodyString);
                 }];
}


/**
 *  Http Post From调用使用，其中query/header/form中的值可以中文
 *  注意pathparameter不允许中文
 */
+ (void) sendHttpPostFormDemo{

    NSString * postPath = @"/testhttp/postform";
    
    NSMutableDictionary *postQueryParams = [[NSMutableDictionary alloc] init];
    [postQueryParams setValue:@"boy" forKey:@"sex"];
    
    NSMutableDictionary *postHeaderParams = [[NSMutableDictionary alloc] init];
    [postHeaderParams setValue:@"HTTP头" forKey:@"TestPostHeader"];
    
    NSMutableDictionary *postFormParams = [[NSMutableDictionary alloc] init];
    [postFormParams setValue:@"FORM表单" forKey:@"TestAccount"];
    
    
    [[HttpUtil instance] httpPost:postPath
                       pathParams:nil
                      queryParams:postQueryParams
                       formParams:postFormParams
                     headerParams:postHeaderParams
                  completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        NSLog(@"Response object: %@" , response);
                        NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                        NSLog(@"Response body: %@" , bodyString);
                     }];
}


/**
 *  Http Post Bytes调用使用，其中query/header/body中的值可以中文
 *  注意pathparameter不允许中文
 */
+ (void) sendHttpPostBytesDemo{
    NSString * postPath = @"/testhttp/postbyte";
    
    NSMutableDictionary *postQueryParams = [[NSMutableDictionary alloc] init];
    [postQueryParams setValue:@"TestQueryNameVlaue" forKey:@"TestQueryName"];
    
    
    NSMutableDictionary *postHeaderParams = [[NSMutableDictionary alloc] init];
    [postHeaderParams setValue:@"TestPostHeaderValue" forKey:@"TestPostHeader"];
    
    NSString * value = @"Hi there ,this is 一个 string";
    NSData * body = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    [[HttpUtil instance] httpPost:postPath
                       pathParams:nil
                      queryParams:postQueryParams
                             body:body
                     headerParams:postHeaderParams
                  completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                      NSLog(@"Response object: %@" , response);
                      NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                      NSLog(@"Response body: %@" , bodyString);
                  }];
    
}


/**
 *  Http Put Bytes调用使用，其中query/header/body中的值可以中文
 *  注意pathparameter不允许中文
 */
+ (void) sendHttpPutBytesDemo{
    
    NSString * postPath = @"/testhttp/putform";
    
    NSMutableDictionary *postQueryParams = [[NSMutableDictionary alloc] init];
    [postQueryParams setValue:@"TestQueryNameVlaue" forKey:@"QueryName"];
    
    NSMutableDictionary *postHeaderParams = [[NSMutableDictionary alloc] init];
    [postHeaderParams setValue:@"TestPostHeaderValue" forKey:@"TestPostHeader"];
    
    NSString * value = @"Hi there ,this is 一个 string";
    NSData * body = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [[HttpUtil instance] httpPut:postPath
                      pathParams:nil
                     queryParams:postQueryParams
                            body:body
                    headerParams:postHeaderParams
                 completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     NSLog(@"Response object: %@" , response);
                     NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                     NSLog(@"Response body: %@" , bodyString);
                 }];


}

/**
 *  Http Delete调用使用，其中query/header中的值可以中文
 *  注意pathparameter不允许中文
 */
+ (void) sendHttpDeleteDemo{

    NSString * deletePath = @"/testhttp/delete";
    
    NSMutableDictionary *deleteQueryParams = [[NSMutableDictionary alloc] init];
    [deleteQueryParams setValue:@"TestQueryNameVlaue" forKey:@"QueryName"];
    
    NSMutableDictionary *deleteHeaderParams = [[NSMutableDictionary alloc] init];
    [deleteHeaderParams setValue:@"TestDeleteValue" forKey:@"TestDelete"];

    
    [[HttpUtil instance] httpDelete:deletePath
                      pathParams:nil
                     queryParams:deleteQueryParams
                    headerParams:deleteHeaderParams
                 completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     NSLog(@"Response object: %@" , response);
                     NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                     NSLog(@"Response body: %@" , bodyString);
                 }];

}

@end
