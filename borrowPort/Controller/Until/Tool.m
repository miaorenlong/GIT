//
//  Tool.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/8.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "Tool.h"
#import <UIKit/UIKit.h>
@implementation Tool

+(Tool *)tool
{
    Tool * tool =[[Tool alloc]init];
    return tool;
}

/**
 得到系统的版本信息

 @return ios的版本信息
 */
-(float)obtainVersion
{
    UIDevice * currentDecice = [UIDevice currentDevice];
    NSString * str = currentDecice.systemVersion;
    float f = [str floatValue];
    return f;
}
@end
