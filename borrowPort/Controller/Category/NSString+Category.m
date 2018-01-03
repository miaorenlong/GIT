//
//  NSString+Category.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/21.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)


-(NSString * )addOne{
    return [NSString stringWithFormat:@"%d",self.intValue + 1];
}
-(NSString *)subtractOne
{
    return [NSString stringWithFormat:@"%d",self.intValue - 1];
}


@end
