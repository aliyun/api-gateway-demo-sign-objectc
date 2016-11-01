//
//  ResultModel.m
//  CloudApiSdkDemo
//
//  Created by  fred on 2016/10/25.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "ResultModel.h"

@implementation ResultModel


+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static ResultModel *resultModel= nil;
    dispatch_once(&onceToken, ^{
        resultModel = [ResultModel new];
    });
    return resultModel;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        resultString= @"";
    }
    return self;
}


@synthesize resultString;

@end
