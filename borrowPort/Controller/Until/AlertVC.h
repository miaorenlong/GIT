//
//  AlertVC.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/11.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertVC : NSObject

+(void)loadAlertConrollerTitle:(NSString *)title WithMessage:(NSString *)message with:(UIViewController *)viewVC;
@end
