//
//  Demo.h
//  CloudApiSdkDemo
//
//  Created by  fred on 2016/10/26.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudApiSdk/CloudApiSdk.h>

@interface ApiClient : NSObject
+ (instancetype) instance;

- (void) sendHttpGetDemo:(NSInteger) userId
                     sex:(NSString *) sex
                     age:(NSInteger) age
         completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock;


- (void) sendHttpPostFormDemo:(NSInteger) userId
                          sex:(NSString *) sex
                          age:(NSInteger) age
              completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock;


- (void) sendHttpPostBytesDemo:(NSInteger) userId
                           age:(NSInteger) age
                          sign:(NSString *) sign
               completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock;


- (void) sendHttpPutBytesDemo:(NSInteger) userId
                          age:(NSInteger) age
                         sign:(NSString *) sign
              completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock;


- (void) sendHttpDeleteDemo:(NSInteger) userId
                        age:(NSInteger) age
            completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock;
@end
