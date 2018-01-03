//
//  ImagePhotoViewController.m
//  borrowPort
//
//  Created by 夏财祥 on 2017/12/14.
//  Copyright © 2017年 众鑫贷. All rights reserved.
//

#import "ImagePhotoViewController.h"
#import <Photos/Photos.h>
#import "Header.h"
@interface ImagePhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableDictionary * dict;
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,strong)UICollectionView * collectionView;
@end

@implementation ImagePhotoViewController

+(instancetype)loadImagePhotoVC{
    UIStoryboard * storyboard =[UIStoryboard storyboardWithName:@"ImageScaleViewController" bundle:nil];
    ImagePhotoViewController * imagePhotoVC = [storyboard instantiateViewControllerWithIdentifier:@"ImagePhotoVC"];
    return imagePhotoVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAgreeAblum];
    // Do any additional setup after loading the view.
    [self initUI];
}
-(void)initUI
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(150, 150);
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"wakaka"];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self loadPhotoAblum];

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
    PHFetchResult * smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    NSLog(@"smartAlbums :%@",smartAlbums);

//    for (NSInteger i = 0; i < smartAlbums.count; i++) {
//        PHCollection * collection =
//    }
    
    
    //所有用户创建的相册
//    PHFetchResult * topUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    //    NSLog(@"topUserCollections :%@",topUserCollections);
    //获取所有资源的集合
//    PHFetchOptions * options = [[PHFetchOptions alloc]init];
//    //    NSLog(@"PHFetchOptions:%@",options);
//    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult * assetsFetchResults = [PHAsset fetchAssetsWithOptions:nil];
    NSLog(@"assetsFetchResults 里面存了多少数据:%lu",(unsigned long)assetsFetchResults.count);
    
    PHCachingImageManager * imageManager = [[PHCachingImageManager alloc]init];

    for (PHAsset * assetSmartImage in assetsFetchResults) {
        [imageManager requestImageForAsset:assetSmartImage targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [self.array addObject:result];
            [self.collectionView reloadData];
        }];
    }
    
}

#pragma mark -- UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wakaka" forIndexPath:indexPath];
//    cell.contentView.im
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    if (self.array.count > 0) {
        imageView.image = self.array[indexPath.row];
    }
    [cell.contentView addSubview:imageView];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
