//
//  RequestBody.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/12.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RequestBody : NSObject

+(instancetype)defualtRequestBody;


//暂时把请求体 定为一个单例的属性  因为暂时了解到每一次请求的请求体为固定的  如果说每次请求都去重写过去繁琐 定在单例中 在这个进程中可以做到随时访问.
@property(nonatomic,strong)NSDictionary * loginRequestBody;

-(NSDictionary *)obtinLoginRequestBodyPhone:(NSString * )phone withPassword:(NSString *)password;

@end
