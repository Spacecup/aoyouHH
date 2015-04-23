//
//  NetworkSingleton.h
//  aoyouHH
//
//  Created by jinzelu on 15/4/22.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBolck)(NSString *error);

//接口域名
#define URL_ROOT @"http://www.haha.mx/mobile_app_data_api.php"
//请求超时
#define TIMEOUT 30

@interface NetworkSingleton : NSObject


/**
 *  单例
 */
+(NetworkSingleton *)sharedManager;
+(AFHTTPRequestOperationManager *)baseHtppRequest;

#pragma mark 推荐关注
-(void)getTuijianAttResult:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBolck)failureBolck;

#pragma mark 最火接口
-(void)getHotestResule:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBolck)failureBlock;


@end
