//
//  calendarView.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/20.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calendarView : UIView

@property(nonatomic,strong)UIView * yearView;
@property(nonatomic,strong)UIView * calendarTure;
@property(nonatomic,strong)UIView * weekView;
@property(nonatomic,strong)UIView * dayLabelView;

@property(nonatomic,copy)NSString * year;
@property(nonatomic,copy)NSString * mouth;

@property(nonatomic,copy)NSString * keyArrayFirst;
@property(nonatomic,copy)NSString * keyArraySecond;

-(instancetype)initWithFrame:(CGRect)frame with:(NSMutableDictionary *)dict with:(NSString *)key;
@property(nonatomic,strong)NSMutableDictionary * dictData;
@property(nonatomic,copy)NSString * key;

@property(nonatomic,strong)NSMutableArray * dayArray;

-(void)updataLabelView:(NSString * )key with:(NSMutableDictionary *)dict;

@end
