//
//  calendarUntil.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/20.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CalendarUntil : NSObject

@property(nonatomic,strong)NSMutableDictionary * dictStatus;
+(instancetype)defaultCalendarUntil;

-(int)getWeekFrom:(NSString *)year with:(NSString *)mouth;
-(int)getFirstWeek:(NSString * )year with:(NSString *)mouth;
@property(nonatomic,strong)NSArray * array;
-(NSArray *)getArrayYearAndMouth;

@property(nonatomic,copy)NSString * year;
@property(nonatomic,copy)NSString * mouth;


-(void)setObjectStatusYear:(NSString *)year withmouth:(NSString *)mouth;
-(void)setObjectStatusWithKey:(NSString *)key;
@end
