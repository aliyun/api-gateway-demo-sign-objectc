//
//  ResultModel.h
//  CloudApiSdkDemo
//
//  Created by  fred on 2016/10/25.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultModel : NSObject
+ (instancetype) instance;
@property (nonatomic) NSString *resultString;
@end
