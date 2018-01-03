//
//  NSDictionary+AvoidVarch.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/14.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AvoidVarch)

/**
 替换方法防止崩溃
 */
+(void)avoidCrashExchangeMethod;

//+(instancetype _Nullable  )avoidCrashDictionaryWithObject:( id _Nullable *_Nullable __unsafe_unretained)objects forKeys:(id _Nullable <NSCopying>*_Nullable __unsafe_unretained)keys counts:(NSUInteger)count;

//+(instancetype _Nullable )avoidCrashDictionaryWithObject:(const id _Nonnull __unsafe_unretained *_Nullable)objects forKeys:(const id<NSCopying> _Nonnull __unsafe_unretained*_Nullable)keys counts:(NSUInteger)count;


@end
