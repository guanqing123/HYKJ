//
//  KJServiceViewController.m
//  HYKJ
//
//  Created by information on 2020/8/26.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJServiceViewController.h"
#import "KJBrowseViewController.h"

#import "KJServiceCollectionViewCell.h"
#import <MJExtension.h>

@interface KJServiceViewController ()

@property (strong , nonatomic)NSMutableArray<KJServiceItem *> *serviceItem;

@end

@implementation KJServiceViewController

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.background & Nav
    [self setupView];
    
    // 2.setData
    [self setData];
}

#pragma mark - init
- (void)setupView {
    // 1.背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 2.注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"KJServiceCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"KJServiceCollectionViewCellID"];
}

#pragma mark - setData
- (void)setData {
    _serviceItem = [KJServiceItem mj_objectArrayWithFilename:@"services.plist"];
    [self.collectionView reloadData];
}

#pragma mark - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _serviceItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //获得cell
    KJServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KJServiceCollectionViewCellID" forIndexPath:indexPath];
    
    KJServiceItem *item = _serviceItem[indexPath.row];
    cell.serviceItem = item;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KJServiceItem *item = _serviceItem[indexPath.row];
    switch (item.serviceType) {
        case ServiceTypeKefu:
            [self browseHTML:[H5URL stringByAppendingString:KefuService]];
            break;
        default:
            break;
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenW / 4, 85);
}

- (void)browseHTML:(NSString *)desUrl {
    KJBrowseViewController *browseVc = [[KJBrowseViewController alloc] initWithDesUrl:desUrl];
    browseVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:browseVc animated:YES];
}

#pragma mark - 屏幕横竖屏设置
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
@end
