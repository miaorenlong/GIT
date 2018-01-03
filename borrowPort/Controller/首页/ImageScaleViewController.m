//
//  ImageScaleViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/13.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "ImageScaleViewController.h"
#import "Header.h"
#import <Photos/Photos.h>
//PHAssetCollection : 一个相簿
//PHImageManager 图片管理者,是单例,发送请求才能从asset获取图片
//PHImageRequestOptions图片请求选项
#import <AssetsLibrary/AssetsLibrary.h>
@interface ImageScaleViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSMutableDictionary * dict;
@property(nonatomic,strong)NSMutableArray * array;
@end

@implementation ImageScaleViewController

+(instancetype)loadImageVC{
    UIStoryboard * storyboard =[UIStoryboard storyboardWithName:@"ImageScaleViewController" bundle:nil];
    ImageScaleViewController * imageScaleVC = [storyboard instantiateViewControllerWithIdentifier:@"imageScal"];
    return imageScaleVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerImageAblum)];
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapOne =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerGetImageAblum)];
    tapOne.numberOfTapsRequired =  2;
    [tap requireGestureRecognizerToFail:tapOne];
    [self.imageView addGestureRecognizer:tapOne];
    [self.imageView addGestureRecognizer:tap];
    if ([ImageObject defultImageObject].image) {
        self.imageView.image = [ImageObject defultImageObject].image;
    }
}

/**
 双击  photokit 自定义相册
 */
-(void)pickerGetImageAblum
{
    [self getAgreeAblum];
    [self loadPhotoAblum];
}

/**
 获取本地相册
 */
-(void)pickerImageAblum
{
    //获取系统相册的类
    UIImagePickerController * pickerController = [[UIImagePickerController alloc]init];
    pickerController.allowsEditing = YES;
    //照片的选择取样
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    UIImagePickerControllerSourceTypeCamera //调取摄像头
//    UIImagePickerControllerSourceTypePhotoLibrary //直接呈现系统相册
    pickerController.delegate = self;
    //使用模态来呈现相册
    [self presentViewController:pickerController animated:YES completion:nil];

}

/**
 简单获取点击的图片的信息

 @param picker pickerController
 @param info  图片的所有信息
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",[info objectForKey:@"UIImagePickerControllerEditedImage"]);
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
 
    if ([ImageObject defultImageObject].image == nil) {
        [ImageObject defultImageObject].image = image;
        self.imageView.image = image;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 获取相册授权
 */
-(void)getAgreeAblum
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        [AlertVC loadAlertConrollerTitle:@"" WithMessage:@"没有打开相册访问权限" with:self];
    }else{
        NSLog(@"获取了用户的权限");
    }
}

/**
 获取相册
 */
-(void)loadPhotoAblum
{
    //所有相册 智能相册
//    PHFetchResult * smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    NSLog(@"smartAlbums :%@",smartAlbums);
    
//    for (NSInteger i = 0; i < smartAlbums.count; i++) {
//        PHCollection * collection =
//    }
    
    
    //所有用户创建的相册
    PHFetchResult * topUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
//    NSLog(@"topUserCollections :%@",topUserCollections);
    //获取所有资源的集合
    PHFetchOptions * options = [[PHFetchOptions alloc]init];
//    NSLog(@"PHFetchOptions:%@",options);
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult * assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
//    NSLog(@"assetsFetchResults :%@",assetsFetchResults);
    
    PHCachingImageManager * imageManager = [[PHCachingImageManager alloc]init];
    PHAsset * assetSmartImage = assetsFetchResults[0];
    [imageManager requestImageForAsset:assetSmartImage targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        NSLog(@"imageResult :%@",result);
//        self.imageView.image = result;
//        NSLog(@"字典是:%@",info);
    }];

}

/**
 获取相簿
 */
-(void)getPhotoAlbum
{
    //获取所有资源的集合,并按照资源的创建时间排序
    PHFetchOptions * options = [[PHFetchOptions alloc]init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    //获取相机胶卷的所有图片
    PHFetchResult * assets = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:nil];
    PHImageRequestOptions * requestOption = [[PHImageRequestOptions alloc]init];
//设置显示模式
/*
 PHImageRequestOptionsResizeModeNone    //选了这个就不会管传如的size了 ，要自己控制图片的大小，建议还是选Fast
 PHImageRequestOptionsResizeModeFast    //根据传入的size，迅速加载大小相匹配(略大于或略小于)的图像
 PHImageRequestOptionsResizeModeExact    //精确的加载与传入size相匹配的图像
 */
    requestOption.resizeMode  = PHImageRequestOptionsResizeModeFast;
    requestOption.synchronous = NO;
    requestOption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    typeof (self)weakSelf = self;
    for (PHAsset * asset in assets) {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(screenSize.width * scale, screenSize.height * scale) contentMode:PHImageContentModeAspectFit options:requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSMutableArray * arrayImage = [NSMutableArray array];
            [weakSelf.dict setObject:asset.localIdentifier forKey:@"localIdentifier"];
            [weakSelf.dict setObject:[UIImage imageWithData:UIImageJPEGRepresentation(result, 0.5)] forKey:@"image"];
            [arrayImage addObject:weakSelf.dict];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@",self.array);
            });
        }];
    }

}


-(NSMutableDictionary *)dict
{
    if (_dict == nil) {
        _dict = [NSMutableDictionary new];
    }
    return _dict;
}
-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray new];
    }
    return _array;
}























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
