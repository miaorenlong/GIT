//
//  MainViewController.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/8.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface MainViewController :RootViewController
@property (weak, nonatomic) IBOutlet UIView *applyView;  //贷款 下方页面
@property (weak, nonatomic) IBOutlet UILabel *doctorLoanLabel;  //医护贷label
@property (weak, nonatomic) IBOutlet UIView *loanTypeView;   //贷款列表页面
@property (weak, nonatomic) IBOutlet UIView *upView;

+(instancetype)loadMainVC;

@end
