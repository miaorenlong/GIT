//
//  LoginViewController.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/11.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface LoginViewController : RootViewController
+(instancetype)loadLoginVC;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumbeTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *verifiTF;

@property(nonatomic,assign)CGFloat keyboardHeight;

@end
