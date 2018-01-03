//
//  AvoidCrash.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/14.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AvoidCrashNotification @"AvoidCrashNotification"
#define AvoidCrashDefaultReturnNil @"this framework default is to return nil"
#define AvoidCrashDefaultIgnore @"this framework default is to ignore this opreation to avoid crash"
@interface AvoidCrash : NSObject

/**
 开始生效 在Appdelegate 的didFinishLaunchingWithOptions 方法中调用becomeEffive方法
 */
+(void)becomeEffective;

+(void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;
+(void)exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbolStr:(NSString *)callStackSymbolStr;
+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo ;



@end
