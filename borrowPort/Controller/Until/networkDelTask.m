//
//  networkDelTask.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/18.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "networkDelTask.h"
#import "Header.h"
@implementation networkDelTask

-(void)requestDataPost:(NSMutableDictionary *)parmart with:(NSURL *)url with:(CustomSessionHeader)customSessionHeader
{
    if ([[url class]isEqual:[@"测试" class]]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    if (url == nil ) {
        return ;
    }
    //网络请求配置信息
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //缓存 请求限制 host 等等
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:0];
    //请求头
    [self optionRequestHeader:request with:customSessionHeader];
    //请求体
    [self optionRequestBody:request with:parmart];
    
    //创建任务
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}
/**
 设置请求头

 @param request request
 @param customSessionHeader 自定义枚举 header
 */
-(void)optionRequestHeader:(NSMutableURLRequest *)request with:(CustomSessionHeader)customSessionHeader
{
    switch (customSessionHeader) {
        case 0:
            [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
            break;
        case 1:
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        default:
            break;
    }
}
/**
 设置请求体  并做加密处理

 @param request request
 */
-(void )optionRequestBody:(NSMutableURLRequest *)request with:(NSDictionary *)parmart
{
    NSString * stringJson = [self convertToJsonData:parmart];
    NSData * data = [RSA encryptData:[stringJson dataUsingEncoding:NSUTF8StringEncoding] publicKey:Public_key_ZH];
    NSData * dataBase64 = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [request setHTTPBody:dataBase64];
}
//1.收到服务器的响应
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    //允许处理服务器的响应,才会继续接收服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}
//接收到服务的数据(可能调用多次)
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
}
//3.请求成功或者失败
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
}
/**
把参数字典 转化成json  并且去掉json中的空格  换行符号  可以添加进入特殊符号
 
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
 *  获取文件上传的请求体信息(二进制)
 *
 *  @param serverFileName 服务器接收文件的字段名
 *  @param filePath       要上传的文件的路径
 *
 *  @return 返回文件上传的请求体二进制信息
 */
- (NSData *)getHTTPBodyWithServerFileName:(NSString *)serverFileName filePath:(NSString *)filePath
{
    // 定义可变的二进制容器,拼接请求体的二进制信息
    NSMutableData *dataM = [NSMutableData data];
    
    // 定义可变字符串,拼接开始的请求体字符串信息
    NSMutableString *stringM = [NSMutableString string];
    // 拼接文件开始上传的分隔符
    [stringM appendString:@"--mac\r\n"];
    // 拼接表单数据
    [stringM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",serverFileName,[filePath lastPathComponent]];
    // 拼接要上传的文件的类型 : 如果你不想告诉服务器你的文件类型具体是什么,就可以使用 "Content-Type: application/octet-stream"
    [stringM appendString:@"Content-Type: image/jpeg\r\n"];
    // 拼接单穿的换行
    [stringM appendString:@"\r\n"];
    
    // 在这里(拼接文件的二进制数据之前),把前面的请求体字符串转换成二进制,先拼接一次
    NSData *stringM_data = [stringM dataUsingEncoding:NSUTF8StringEncoding];
    [dataM appendData:stringM_data];
    
    // 拼接文件的二进制数据
    NSData *file_data = [NSData dataWithContentsOfFile:filePath];
    [dataM appendData:file_data];
    
    NSString *end = @"\r\n--mac--";
    [dataM appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    return dataM.copy;
}

@end
