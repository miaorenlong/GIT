//
//  UIView+Category.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/20.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

-(CGFloat)height
{
    return self.frame.size.height;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(CGFloat)originX
{
    return self.frame.origin.x;
}
-(CGFloat)originY
{
    return self.frame.origin.y;
}

@end
