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

#import "SignUtil.h"

@implementation SignUtil

/**
 *  签名方法
 *  本方法将Request中的httpMethod、headers、path、queryParam、formParam合成一个字符串用hmacSha256算法双向加密进行签名
 */
+(NSString *) sign:(NSString *) httpMethod
           headers:(NSMutableDictionary *) headers
              path:(NSString *) path
        queryParam:(NSDictionary *) queryParam
         formParam:(NSString *) formParam{
    
    //将Request中的httpMethod、headers、path、queryParam、formParam合成一个字符串
    NSString * data = [SignUtil buildStringToSign: headers path:path queryParam:queryParam formParam:formParam method:httpMethod];
    
    //对字符串进行hmacSha256加密，然后再进行BASE64编码
    return [SignUtil hmacSha256:APP_SECRET data:data];
    
}

@end
@implementation SignUtil(private)


/**
 * 将Request中的httpMethod、headers、path、queryParam、formParam合成一个字符串
 */
+(NSString *) buildStringToSign:(NSMutableDictionary *) headers
                           path:(NSString *) path
                     queryParam:(NSDictionary *) queryParam
                      formParam:(NSString *) formParam
                         method:(NSString *) method{
    
    NSMutableString * result = [[NSMutableString alloc] initWithFormat:@"%@%c" , method , CLOUDAPI_LF];
    
    //如果有@"Accept"头，这个头需要参与签名
    if(nil != [headers objectForKey:CLOUDAPI_HTTP_HEADER_ACCEPT]){
        [result appendString:[headers valueForKey:CLOUDAPI_HTTP_HEADER_ACCEPT]];
    }
    [result appendFormat:@"%c" , CLOUDAPI_LF];

    //如果有@"Content-MD5"头，这个头需要参与签名
    if(nil != [headers objectForKey:CLOUDAPI_HTTP_HEADER_CONTENT_MD5]){
        [result appendString: [headers valueForKey:CLOUDAPI_HTTP_HEADER_CONTENT_MD5]];
    }
    [result appendFormat:@"%c" , CLOUDAPI_LF];
    
    //如果有@"Content-Type"头，这个头需要参与签名
    if(nil != [headers objectForKey:CLOUDAPI_HTTP_HEADER_CONTENT_TYPE]){
        [result appendString: [headers valueForKey:CLOUDAPI_HTTP_HEADER_CONTENT_TYPE]];
    }
    [result appendFormat:@"%c" , CLOUDAPI_LF];
    
    //如果有@"Date"头，这个头需要参与签名
    if(nil != [headers objectForKey:CLOUDAPI_HTTP_HEADER_DATE]){
        [result appendString:[headers valueForKey:CLOUDAPI_HTTP_HEADER_DATE]];
    }
    [result appendFormat:@"%c" , CLOUDAPI_LF];


     //将headers合成一个字符串
    [result appendString:[SignUtil buildHeaders:headers]];
    
    //将path、queryParam、formParam合成一个字符串
    [result appendString:[SignUtil buildResource:path queryParam:queryParam formParam:formParam]];
    
    return result;
    
}


/**
 *  将headers合成一个字符串
 *  需要注意的是，HTTP头需要按照字母排序加入签名字符串
 *  同时所有加入签名的头的列表，需要用逗号分隔形成一个字符串，加入一个新HTTP头@"X-Ca-Signature-Headers"
 */
+(NSString *) buildHeaders:(NSMutableDictionary *) headers{
    NSMutableString * signHeaders  = [[NSMutableString alloc] init];
    NSMutableString * result = [[NSMutableString alloc] init];
    
    //使用NSMutableOrderedSet好排序
    NSMutableOrderedSet * signHeaderNames = [[NSMutableOrderedSet alloc] init];
    if(nil != headers){
        bool isFirst = true;
        for(id key in headers){
            if([key hasPrefix:CLOUDAPI_CA_HEADER_PREFIX]){
                if(!isFirst){
                    [signHeaders appendString:@","];
                }
                isFirst = false;
                
                [signHeaders appendString:key];
                [signHeaderNames addObject:key];
            }
        }
        //同时所有加入签名的头的列表，需要用逗号分隔形成一个字符串，加入一个新HTTP头@"X-Ca-Signature-Headers"
        [headers setValue:signHeaders forKey:CLOUDAPI_X_CA_SIGNATURE_HEADERS];
        
    }
    
    for(int i = (int)([signHeaderNames count]-1) ; i > -1  ; i--){
        [result appendFormat:@"%@:%@%c" , [signHeaderNames objectAtIndex:i] , [headers objectForKey:[signHeaderNames objectAtIndex:i]] , CLOUDAPI_LF];
    }
    
    return result;
}


/**
 * 将path、queryParam、formParam合成一个字符串
 */
+(NSString *) buildResource:(NSString *) path queryParam:(NSDictionary *) queryParam formParam:(NSString *) formParam{
    NSMutableString * result = [[NSMutableString alloc] initWithString:path];
    
    if(nil != queryParam || nil != formParam){
        [result appendString:@"?"];
    }
    bool hasForm = false;
    
    if(nil != formParam && [formParam length] > 0){
        [result appendString:formParam];
        hasForm = true;
    }
    
    if(nil != queryParam){
        bool isFirst = true;
        for(id key in queryParam){
            if(isFirst != true || hasForm == true){
                [result appendString:@"&"];
            }
            
            isFirst = false;
            [result appendFormat:@"%@=%@" , key , [queryParam objectForKey:key]];
        }
    }
    
    return result;
}

/**
 *  对字符串进行hmacSha256加密，然后再进行BASE64编码
 */
+(NSString *)hmacSha256:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    //将加密结果进行一次BASE64编码
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];
    return hash;
}


@end