//
//  RequestBody.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/12.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "RequestBody.h"

@implementation RequestBody
//创建静态对象  防止外部访问
static RequestBody * requestBody;

//重写这个方法  保证永远都只为单例对象分配一次内存空间
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestBody = [super allocWithZone:zone];
    });
    return  requestBody;
}
+(instancetype)defualtRequestBody
{
    return  [[self alloc]init];
}

/**
 GET 懒加载的赶脚

 @return 登录请求 body
 */
-(NSDictionary *)loginRequestBody
{
    if (_loginRequestBody == nil) {
        _loginRequestBody = [NSDictionary dictionary];
        
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
        NSMutableDictionary * parm = [NSMutableDictionary dictionary];
        [parm setObject:@"userAccountService.login" forKey:@"method"];
        [parm setObject:[NSString stringWithFormat:@"%.0f",interval] forKey:@"id"];
        [parm setObject:@"1.0" forKey:@"jsonrpc"];
        NSMutableArray * array = [NSMutableArray array];
        NSMutableDictionary * dictArr = [NSMutableDictionary dictionary];
        [array addObject:dictArr];
        [dictArr setObject:@"123" forKey:@"agentNum"];
        [dictArr setObject:@"ios" forKey:@"channel"];
        [dictArr setObject:@"login" forKey:@"code"];
        [dictArr setObject:@"123" forKey:@"password"];
        [dictArr setObject:@"ios" forKey:@"sources"];
        
        UIDevice * device = [UIDevice currentDevice];
        [dictArr setObject:device.systemName forKey:@"system"];  //登录系统设备
        [dictArr setObject:@"13125898569" forKey:@"telephone"];
        [dictArr setObject:[NSString stringWithFormat:@"%.0f",interval] forKey:@"timestamp"];
        [parm setObject:array forKey:@"params"];
        _loginRequestBody = parm;
    }
    return _loginRequestBody;
}

-(NSDictionary *)obtinLoginRequestBodyPhone:(NSString * )phone withPassword:(NSString *)password
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSMutableDictionary * parm = [NSMutableDictionary dictionary];
    [parm setObject:@"userAccountService.login" forKey:@"method"];
    [parm setObject:[NSString stringWithFormat:@"%.0f",interval] forKey:@"id"];
    [parm setObject:@"1.0" forKey:@"jsonrpc"];
    NSMutableArray * array = [NSMutableArray array];
    NSMutableDictionary * dictArr = [NSMutableDictionary dictionary];
    [array addObject:dictArr];
    [dictArr setObject:@"123" forKey:@"agentNum"];
    [dictArr setObject:@"ios" forKey:@"channel"];
    [dictArr setObject:@"login" forKey:@"code"];
    [dictArr setObject:password forKey:@"password"];
    [dictArr setObject:@"ios" forKey:@"sources"];
    
    UIDevice * device = [UIDevice currentDevice];
    [dictArr setObject:device.systemName forKey:@"system"];  //登录系统设备
    [dictArr setObject:phone forKey:@"telephone"];
    [dictArr setObject:[NSString stringWithFormat:@"%.0f",interval] forKey:@"timestamp"];
    [parm setObject:array forKey:@"params"];
    return parm;
}






























@end
