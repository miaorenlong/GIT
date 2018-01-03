
//
//  CustomTableView.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/23.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    id view = [super hitTest:point withEvent:event];
    NSLog(@"返回的都是啥:%@",view);
    if (![view isKindOfClass:[UITextField class]]) {
        [self.superview endEditing:YES];
        [self endEditing:YES];
    }
    return view;
}





















@end





