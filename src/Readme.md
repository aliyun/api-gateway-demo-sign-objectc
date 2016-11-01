# Api-Gateway-Demo-ObjectC SDK源码
## 1 SDK简介

本套程序是阿里云API网关团队提供给用户的API网关的HTTP底层通讯SDK源码，实现了CloudApi的签名算法和一系列Http调用，解决了您的HTTP通讯问题，您可以在本源码上层定制您自己的SDK。我们同时提供了封装好的framework形式的SDK。如果您只是简单的调用，直接使用我们提供封装好的framework版本即可。源码所在地址为https://github.com/aliyun/api-gateway-demo-sign-objectc/sdk，本SDK具体提供了一下五种HTTP通讯接口：  

* Http Get  
* Http Post Form
* Http Post Bytes
* Http Put Bytes
* Http Delete


本源码的代码文件的层级结构如下：  

* src	
	* CloudApiSdk.m/CloudApiSdk.h	`SDK处理HTTP请求的类`
	* AppConfiguration.m/AppConfiguration.m	`SDK配置类`
	* SignUtil.m/SignUtil.h	`签名的实现类`
	* HttpConstant.h	`SDK用到的Http常量`
	* SDKConstant.h	`SDK内部用到的常量`




## 3 SDK使用

### 3.1 初始化SDK

本SDK需要将你的AppKey和AppSecret初始化后，才能正常使用，初始化的语句方法如下：

	
	[[AppConfiguration instance] setAPP_KEY:@""];
	[[AppConfiguration instance] setAPP_SECRET:@""];
	    
	
### 3.2 发送HTTP请求

	    
	//定义Path
	NSString * path = @"/v3/getUserTest/[userId]";
	    
	//定义PathParameter
	NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
	[pathParams setValue:[NSString stringWithFormat:@"%ld" , 10000094] forKey:@"userId"];
	    
	//定义QueryParameter
	NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
	[queryParams setValue:@"boy" forKey:@"sex"];
	    
	//定义HeaderParameter
	NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
	[headerParams setValue:[NSString stringWithFormat:@"%ld" , 18] forKey:@"age"];
	    
	[[CloudApiSdk instance] httpGet: CLOUDAPI_HTTP
	                               host: HOST
	                               path: path
	                         pathParams: pathParams
	                        queryParams: queryParams
	                       headerParams: headerParams
	                    completionBlock: ^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
	                              
	                              dispatch_async(dispatch_get_main_queue(), ^{
	                                  NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
	                                  [[ResultModel instance] setResultString:[NSString stringWithFormat:@"Http Get Response object:%@\nHttp Get Response Body:\n%@" , response , bodyString]];
	                                  [self performSegueWithIdentifier:@"getResultSegue" sender:nil];
	                              });
	
	                          }];completionBlock];

如果在使用中遇到棘手的问题，请加入我们官方旺旺群来找我们，群号：1640106170