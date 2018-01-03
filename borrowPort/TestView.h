//
//  TestView.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/19.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cornerBtn;
@property (weak, nonatomic) IBOutlet UIButton *anotherBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *annotherBtnWidhConst;

+(instancetype)defaultTestView;


@end
