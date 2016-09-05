# Api-Gateway-Demo-ObjectC 使用指南
## 1 SDK简介

本SDK是阿里云CloudApi团队提供给用户的调用示例代码，代码文件的层级结构如下：

* SDK文件夹		`所有SDK的代码都在本文件夹中 ` 
	* HttpUtil.h/HttpUtil.m		`Http工具类`
	* SignUtil.h/SignUtil.m		`签名的实现类`
	* AppConfiguration.h	`所有SDK的配置设置`
	* AppInclude.h	`所有常量、配置文件的引用`
	* Constant文件夹
		* ContentType.h	`常用HTTP Content-Type常量`
		* HttpHeader.h	`HTTP头常量`
		* HttpMethod.h	`HTTP方法常量`
		* HttpSchema.h	`HTTP Schema常量`
		* Constants.h		`通用常量`
		* SystemHeader.h	`系统HTTP头常量`

* Demo.h/Demo.m	`调用示例`

本SDK实现了CloudApi的签名算法和一系列Http调用示例，可以在Demo.h看到具体调用办法：  

* Http Get  
* Http Post Form
* Http Post Bytes
* Http Put Bytes
* Http Delete

其中SDK的签名算法比较复杂，如果想了解其中的算法细节，请到此网址查看：
`https://help.aliyun.com/document_detail/29475.html

## 2 SDK配置

本SDK需要配置好之后才能正常使用，在SDK/AppConfiguration.h中，有三个值是必须配置的：

	/**
	 *  Api绑定的的AppKey，可以在“阿里云官网”->"API网关"->"应用管理"->"应用详情"查看
	 */
	static NSString *APP_KEY = @"";
	
	/**
	 *  Api绑定的的AppSecret，用来做传输数据签名使用，可以在“阿里云官网”->"API网关"->"应用管理"->"应用详情"查看
	 */
	static NSString *APP_SECRET = @"";
	
	/**
	 *  Api绑定的域名，只包含域名和端口号
	 *  比如：baidu.com:8080
	 */
	static NSString *APP_HOST = @"";

**重要提示：APP_KEY和APP_SECRET是网关认证用户请求的钥匙，这两个配置如果保存在客户端，需要加密处理。** 

## 3 SDK使用

### 3.1 把SDK引入你的项目
配置完成之后，本SDK就可以使用了，具体使用办法如下：

1. 把SDK文件夹复制到你项目文件夹中；
2. 在Project文件夹上右键点击，在弹出来的选项框中选择`Add Files To "Your project name"`，然后选中SDK文件夹，注意在本窗口左下角有Options选线按钮，点击此按钮，在跳出来的选项中勾选“Create groups”，然后再点击Add按钮；

### 3.2 工程中引入头文件

	#import "HttpUtil.h"
	

### 3.3 调用Demo

然后可以像Demo.m中的各个方法一样调用HttpUtil类发送各种类型的Http请求:

#### 3.3.1 Http Get

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
	
#### 3.3.2 Http Post Form

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


#### 3.3.3 Http Post Bytes

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
	
####3.3.4 Http Put Bytes

	/**
	 *  Http Put Bytes调用使用，其中query/header/body中的值可以中文
	 *  注意pathparameter不允许中文
	 */
	+ (void) sendHttpPutBytesDemo{
    
	    NSString * postTestPath = @"/testhttp/putform";
	    
	    NSMutableDictionary *postTestQueryParams = [[NSMutableDictionary alloc] init];
	    [postTestQueryParams setValue:@"TestQueryNameVlaue" forKey:@"QueryName"];
	    
	    NSMutableDictionary *postTestHeaderParams = [[NSMutableDictionary alloc] init];
	    [postTestHeaderParams setValue:@"TestPostHeaderValue" forKey:@"TestPostHeader"];
	    
	    NSString * value = @"Hi there ,this is 一个 string";
	    NSData * body = [value dataUsingEncoding:NSUTF8StringEncoding];
	    
	    
	    [[HttpUtil instance] httpPut:postTestPath
	                      pathParams:nil
	                     queryParams:postTestQueryParams
	                            body:body
	                    headerParams:postTestHeaderParams
	                 completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
	                     NSLog(@"Response object: %@" , response);
	                     NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
	                     NSLog(@"Response body: %@" , bodyString);
	                 }];
	
	
	}
	
#### 3.3.5 Http Put Bytes
	
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
	
如果在使用中遇到棘手的问题，请加入我们官方旺旺群来找我们，群号：1640106170