//
//  TestTouchView.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/25.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "TestTouchView.h"

@implementation TestTouchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    id view =  [super hitTest:point withEvent:event];
    NSLog(@"%ld",(long)self.tag);
    return view;
}


@end
