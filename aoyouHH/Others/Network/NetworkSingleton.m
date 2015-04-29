//
//  NetworkSingleton.m
//  aoyouHH
//
//  Created by jinzelu on 15/4/22.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "NetworkSingleton.h"
#import "JokeModel.h"
#import "TuijianAttModel.h"
#import "UserModel.h"
#import "UserSingleton.h"


@interface NetworkSingleton ()

@end


@implementation NetworkSingleton

+(NetworkSingleton *)sharedManager{
    static NetworkSingleton *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}

-(AFHTTPRequestOperationManager *)baseHtppRequest{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //timeout设置
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    
    //header 设置
    //    [manager.requestSerializer setValue:K_PASS_IP forHTTPHeaderField:@"Host"];
    //    [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
//        [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    //    [manager.requestSerializer setValue:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
    //    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    //    [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    //     [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" forHTTPHeaderField:@"User-Agent"];
    return manager;
}

#pragma mark 登录接口
-(void)userLogin:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBolck)failureBolck{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url = [NSString stringWithFormat:@"%@",URL_ROOT];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
//        NSLog(@"登录：%@",responseObject);
        UserModel *user = [self getUserModel:responseObject];
        //保存用户登录信息
        [[UserSingleton sharedManager] setUser:user];
        successBlock(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error:%@",error.localizedFailureReason);
        failureBolck(@"用户名或密码错误");
        
    }];
}

#pragma mark 推荐关注
-(void)getTuijianAttResult:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBolck)failureBolck{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url = [NSString stringWithFormat:@"%@",URL_ROOT];
    //转码
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //请求
    [manager POST:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSArray *tuijianAtt = [[NSArray alloc] init];
        tuijianAtt = [self getTuijianAttFromDicArray:responseObject];
        
        successBlock(tuijianAtt);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBolck(error.localizedFailureReason);
    }];
}

#pragma mark 最火接口
-(void)getHotestResule:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBolck)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url = [NSString stringWithFormat:@"%@",URL_ROOT];
    //编码
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *resultDic = [responseObject objectForKey:@"joke"];
        
        //JokeModel
        NSArray *jokeArr = [[NSArray alloc] init];
        jokeArr = [self getJokeFromDicArray:[responseObject objectForKey:@"joke"]];
        
        successBlock(jokeArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"getHotestResule:%@",error);
        failureBlock(@"网络或者服务器错误");
    }];
}

#pragma mark 获取一条笑话
-(void)getOneJokeResule:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBolck)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url = [NSString stringWithFormat:@"%@",URL_ROOT];
    //转码
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSMutableArray *jokeArr = [[NSMutableArray alloc] init];
        jokeArr = [self getJokeFromDicArray:responseObject];
        successBlock(jokeArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"getOneJokeResule:%@",error);
        failureBlock(@"网络或者服务器错误");
    }];
}

//==================================登录=======================================
-(id)getUserModel:(NSDictionary *)dic{
    UserModel *result = [[UserModel alloc] init];
    
    result.score = [self getDicValue:dic andKey:@"score"];
    result.level = [self getDicValue:dic andKey:@"level"];
    result.name = [self getDicValue:dic andKey:@"name"];
    result.avatar = [self getDicValue:dic andKey:@"avatar"];
    result.com = [self getDicValue:dic andKey:@"com"];
    result.mes = [self getDicValue:dic andKey:@"mes"];
    
    return result;
}

//==================================关注=======================================
//推荐关注数组
-(NSArray *)getTuijianAttFromDicArray:(NSArray *)array{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if (array) {
        for (NSDictionary *dic in array) {
            [result addObject:[self getTuijianAttModel:dic]];
        }
    }
    return result;
}


//获取推荐关注
-(id)getTuijianAttModel:(NSDictionary *)dic{
    TuijianAttModel *tuijianAtt = [[TuijianAttModel alloc] init];
    tuijianAtt.id = [self getDicValue:dic andKey:@"id"];
    tuijianAtt.content = [self getDicValue:dic andKey:@"content"];
    tuijianAtt.number = [self getDicValue:dic andKey:@"number"];
    tuijianAtt.follower = [self getDicValue:dic andKey:@"follower"];
    tuijianAtt.hot = [self getDicValue:dic andKey:@"hot"];
    tuijianAtt.recommend = [self getDicValue:dic andKey:@"recommend"];
    tuijianAtt.att = [self getDicValue:dic andKey:@"att"];
    
    return tuijianAtt;
}

//=============================最火，趣图，最新，文字===========================
//joke数组
-(NSArray *)getJokeFromDicArray:(NSArray *)array{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if (array) {
        for (NSDictionary *dic in array) {
            [result addObject:[self getJokeModel:dic]];
        }
    }
    return result;
}


//获取joke
-(id)getJokeModel:(NSDictionary *)dic{
    JokeModel *joke = [[JokeModel alloc] init];
    joke.id = [self getDicValue:dic andKey:@"id"];
    joke.content = [self getDicValue:dic andKey:@"content"];
    joke.uid = [self getDicValue:dic andKey:@"uid"];
    joke.time = [self getDicValue:dic andKey:@"time"];
    joke.good = [self getDicValue:dic andKey:@"good"];
    joke.bad = [self getDicValue:dic andKey:@"bad"];
    joke.vote = [self getDicValue:dic andKey:@"vote"];
    joke.comment_num = [self getDicValue:dic andKey:@"comment_num"];
    joke.anonymous = [self getDicValue:dic andKey:@"anonymous"];
    joke.appid = [self getDicValue:dic andKey:@"appid"];
    joke.topic = [self getDicValue:dic andKey:@"topic"];
    joke.topic_content = [self getDicValue:dic andKey:@"topic_content"];
    
    joke.pic = [self getPicModel:[self getDicValue:dic andKey:@"pic"]];
    
    joke.user_name = [self getDicValue:dic andKey:@"user_name"];
    joke.user_pic = [self getDicValue:dic andKey:@"user_pic"];
    
    return joke;
}
//获取pic
-(id)getPicModel:(NSDictionary *)dic{
    if (dic == nil) {
        return nil;
    }
    PicModel *pic = [[PicModel alloc] init];
    pic.path = [self getDicValue:dic andKey:@"path"];
    pic.name = [self getDicValue:dic andKey:@"name"];
    pic.width = [self getDicValue:dic andKey:@"width"];
    pic.height = [self getDicValue:dic andKey:@"height"];
    pic.animated = [self getDicValue:dic andKey:@"animated"];
    
    return pic;
}
//获取字典里的值
-(id)getDicValue:(NSDictionary *)dic andKey:(NSString *)key{
    id result = nil;
    if (![[dic objectForKey:key] isKindOfClass:[NSNull class]]) {
        return [dic objectForKey:key];
    }
    return result;
}

































@end