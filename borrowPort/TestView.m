//
//  TestView.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/19.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "TestView.h"

@implementation TestView

+(instancetype)defaultTestView
{
    TestView * testView = [[[NSBundle mainBundle]loadNibNamed:@"TestView" owner:self options:nil] lastObject];
    return testView;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%@ %@ %@",self,self.cornerBtn,self.anotherBtn);
}
-(void)layoutSubviews
{
    NSLog(@"%@ %@ %@",self,self.cornerBtn,self.anotherBtn);
}
-(void)drawRect:(CGRect)rect
{
//    if (self.cornerBtn.hidden) {
//        self.annotherBtnWidhConst.constant = self.frame.size.width;
//        [self setHalfCorner:self.anotherBtn];
//    }else
//    {
//        self.annotherBtnWidhConst.constant =self.frame.size.width/2;
//        [self setOneHalfCorner:self.cornerBtn with:UIRectCornerBottomLeft];
//        [self setOneHalfCorner:self.anotherBtn with:UIRectCornerBottomRight];
//    }
//    [self setOneHalfCorner:self.cornerBtn with:UIRectCornerBottomLeft];
//    [self setOneHalfCorner:self.anotherBtn with:UIRectCornerBottomRight];
    self.annotherBtnWidhConst.constant =self.frame.size.width/2;
    
    [self setNeedsUpdateConstraints];
    

}

//- (void)setNeedsDisplay
//{
//}
//-(void)setNeedsLayout
//{
//}
//
///**
// 这个好像是部分更新约束
// */
//-(void)setNeedsUpdateConstraints
//{
//}
//- (void)setNeedsDisplayInRect:(CGRect)rect
//{
//}

-(void)setHalfCorner:(UIButton *)btn
{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(50.f, 10.f)];
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.frame = btn.bounds;
    shape.path = maskPath.CGPath;
    btn.layer.mask = shape;
}
-(void)setOneHalfCorner:(UIButton *)btn with:(UIRectCorner)corner
{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(50.f, 50.f)];
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.frame = btn.bounds;
    shape.path = maskPath.CGPath;
    btn.layer.mask = shape;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
 
 第一步走+(instancetype)defaultTestView,进入方法===> 然后走[NSBundle mainBundle]loadNibNamed方法 ===> 走setNeedsDisplay方法 走三次,子控件在这方法里面没有做处理 ====>然后走 awakeFromNib方法,得到子控件的所有信息===> 返回初始化方法,return 对象 得到对象 ==>
 */
/*
 对象的frame更改后  走这个setNeedsLayout方法
 */
/*
 初始化方法没有走return方法前都说明外界没有接受到创建的view对象.
 awakeFromNib 方法介绍里面说没有进入代码,理解为不能接受外界的参数,测试也证实参数不能在这里面传递.
 */
/*
 setNeedsDisplay 方法调用三次 三次输出结果为:
 1.frame = (-247.5 -103.5; 495 207); opaque = NO; layer = <CALayer: 0x6040002326a0>> (null) (null)
 2.frame = (0 0; 495 207); layer = <CALayer: 0x6040002326a0>> (null) (null)
 3.frame = (0 0; 495 207); autoresize = W+H; layer = <CALayer: 0x6040002326a0>> (null) (null)
 
 setNeedsDisplay这个方法在再次运行自定义view的时候 走了16次  我靠  搞毛啊
 
 */
/*
 layoutSubviews
 */






@end
