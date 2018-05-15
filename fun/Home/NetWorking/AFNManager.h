//
//  AFNManager.h
//  fun
//
//  Created by 123 on 2018/5/14.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);

@interface AFNManager : NSObject
//get请求
+(void)getWithUrlString:(NSString *)urlString parameter:(NSDictionary*)para success:(HttpSuccess)success failure:(HttpFailure)failure;


//post请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
