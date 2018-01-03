//
//  ImageScaleViewController.h
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/13.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScaleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

+(instancetype)loadImageVC;

@end
