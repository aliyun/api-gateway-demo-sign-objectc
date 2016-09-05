//
//  SystemHeader.h
//  CloudApiSdkDemo
//
//  Created by  fred on 2016/8/30.
//  Copyright © 2016年 fredAlibabaalibaba. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * 系统HTTP头常量
 */

//签名Header
static NSString* const CLOUDAPI_X_CA_SIGNATURE = @"X-Ca-Signature";

//所有参与签名的Header
static NSString* const CLOUDAPI_X_CA_SIGNATURE_HEADERS = @"X-Ca-Signature-Headers";

//请求时间戳
static NSString* const CLOUDAPI_X_CA_TIMESTAMP =  @"X-Ca-Timestamp";

//APP KEY
static NSString* const CLOUDAPI_X_CA_KEY = @"X-Ca-Key";

//签名算法版本号
static NSString* const CLOUDAPI_X_CA_VERSION =  @"X-Ca-Version";

