//
//  NSDictionary+AvoidVarch.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/14.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "NSDictionary+AvoidVarch.h"
#import "AvoidCrash.h"
@implementation NSDictionary (AvoidVarch)

+(void)avoidCrashExchangeMethod
{
    [AvoidCrash exchangeClassMethod:self method1Sel:@selector(dictionaryWithObjects:forKeys:count:) method2Sel:@selector(avoidCrashDictionaryWithObject:forKeys:counts:)];
}


+(instancetype)avoidCrashDictionaryWithObject:(const id _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying> _Nonnull __unsafe_unretained*)keys counts:(NSUInteger)count
{
    id instance = nil;
    @try{
        instance = [self avoidCrashDictionaryWithObject:objects forKeys:keys counts:count];
    }
    @catch(NSException * exception){
        NSString * defaultToDo = @"走了dictionary categray转换方法";
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        //处理错误的数据  然后重新初始化一个字典
        NSUInteger index = 0;
        id _Nonnull __unsafe_unretained newObjects[count];
        id _Nonnull __unsafe_unretained newKeys[count];
        for (int i = 0 ; i < count; i ++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newKeys[index] = keys[i];
                index ++;
            }
        }
        instance = [self avoidCrashDictionaryWithObject:newObjects forKeys:newKeys counts:index];
    }
    @finally{
        return instance;
    }
}



















@end
