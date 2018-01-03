//
//  TestTouchViewController.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/25.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestTouchView.h"
@interface TestTouchViewController : UIViewController
@property (weak, nonatomic) IBOutlet TestTouchView *firstLevel;
@property (weak, nonatomic) IBOutlet TestTouchView *secondLevelOne;
@property (weak, nonatomic) IBOutlet TestTouchView *secondLevelTwo;
@property (weak, nonatomic) IBOutlet TestTouchView *thirdLevelOne;
@property (weak, nonatomic) IBOutlet TestTouchView *thirdLevelTwo;
@property (weak, nonatomic) IBOutlet TestTouchView *forthLevelOne;
@property (weak, nonatomic) IBOutlet TestTouchView *forthLevelTwo;



@end
