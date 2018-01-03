//
//  NetworkTask.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/11.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "NetworkTask.h"
#import "Header.h"

#define DebugEnvironment @"http://192.168.1.245:8081"///<测试环境
NSString *const TaskRequestBanner = @"/banner/info";

@implementation NetworkTask


/**
 post  网络请求

 @param url 请求的url (以后这个肯定不能写url 需要封装成更方便的固定string)
 @param CustomSessionHeader header的 Content-Type,后期再根据具体情况封装header
 @param parmart 请求参数做了一个单例的处理 每一种请求body都是固定的 在单例中方便看
 */
-(void)obtainPOSTDataFrom:(NSURL *)url With:(CustomSessHeader)CustomSessionHeader Withparmart:(NSMutableDictionary * )parmart
{
    if ([[url class]isEqual:[@"测试" class]]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    if (url == nil ) {
        return ;
    }
    NSURLSession * session = [NSURLSession sharedSession];
    //request 网络请求
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:0];
    //设置请求头
    [self setCustomHeader:CustomSessionHeaderXmlJson With:request];
    //设置请求方法
    [request setHTTPMethod:@"POST"];

    //设置请求体
    [request setHTTPBody:[self setRequestBodyWith:parmart]];

    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"block的线程 :%@",[NSThread currentThread]);
        NSLog(@"响应头:%@",response);
        if (error) {
            [self errordispose:error];
        }
    }];
    //开始任务
    [dataTask resume];
    //暂停或者停止任务
//    [session invalidateAndCancel];
//    [session finishTasksAndInvalidate];
    
}
-(void)uploadImage:(NSURLSession *)session
{
    NSMutableURLRequest * request ;
    UIImage * image;
    NSData * imageData = UIImageJPEGRepresentation(image, 1.0);
    NSURLSessionUploadTask * uplaodTask = [session uploadTaskWithRequest:request fromData:imageData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",response);
    }];
    [uplaodTask resume];
}

/**
 返回请求体 加密过的nsdata

 @param parmart 字典 请求体 body
 */
-(NSData *)setRequestBodyWith:(NSMutableDictionary * )parmart
{
    //版本号
    [parmart setObject:@"4.0.0" forKey:@"apiVersion"];
    //JSON 要传给服务器的参数
    NSString * JsonString = [self convertToJsonData:parmart];
    NSData * data = [RSA encryptData:[JsonString dataUsingEncoding:NSUTF8StringEncoding] publicKey:Public_key_ZH];
    NSData * dataBase64 = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSString * JsonString = [self convertToJsonData:parmart];
//    NSString * stringRSA = [RSA encryptString:JsonString publicKey:RSAKey];
//    NSDictionary * dict = @{@"data":stringRSA};
//    NSData * data = [[self convertToJsonData:dict] dataUsingEncoding:NSUTF8StringEncoding];
    return dataBase64;
}
/**
 返回请求头

 @param CustomHeader 自定义的枚举类型
 @param request 网络请求
 */
-(void)setCustomHeader:(CustomSessHeader )CustomHeader With:(NSMutableURLRequest *)request
{

    switch (CustomHeader) {
        case 0:
            [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
            break;
        case 1:
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        default:
            
            break;
    }
}
/**
 请求体body  把参数字典 转化成json  并且去掉json中的空格  换行符号  可以添加进入特殊符号
 
 @param dict body
 @return json
 */
-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
/**
 error 处理

 @param error error
 */
-(void)errordispose:(NSError *)error
{
    if ([[self.taskDelegate class] isEqual:[[UIViewController new]class]]) {
        [AlertVC loadAlertConrollerTitle:@"警告" WithMessage:@"请求错误" with:self.taskDelegate];
    }
}
-(void)wakaka
{
    NSString * encryString = @"HtagNedkNNL2cLYMLCVpFd+Hq9P7cqjZcc2CwP4b2EoNiD06bBBSR7mq4Ni+DTC/G2q4EqjyqG3pXpaux0QYZzJVeaUiscYjvLp3RpdARxF4jfoZOuCCoh/Qg/OskCchuZPWWesPWET+PtHYFGuzxRuY2ZdJkzBnIJnP5ZPqc0YVveRwJZGZi4Ch7uP3KniHxfMLtuWY/PM2/dNKtEu0EIuJ+lVEU36YQbSLkusBYu26lWzFYO+i3GTrUVASuxKm2VztA3qBeixF5WS2UZjGsAbSosh/kv/+UMgtgxYdT/ynlUxqbuHOuM21GllOkjrgS2P8Dl7iOmULu3CcMsb6Lg==";
    
    
    
    NSData * dataBase64 = [[NSData alloc]initWithBase64EncodedString:encryString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSData * data = [RSA decryptData:dataBase64 publicKey:Public_key_ZH];
    NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",dict);
}

@end
