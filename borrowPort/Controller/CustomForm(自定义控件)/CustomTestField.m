//
//  CustomTestField.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/26.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "CustomTestField.h"

@implementation CustomTestField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@synthesize placeholder = _placeholder;

-(void)setPlaceholder:(NSString *)placeholder
{
    NSLog(@"%@",placeholder);
    _placeholder = @"设置无用";
    [super setPlaceholder:_placeholder];
}
-(NSString *)placeholder
{
    return _placeholder;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}


@end
