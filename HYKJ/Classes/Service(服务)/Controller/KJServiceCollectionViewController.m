//
//  KJServiceCollectionViewController.m
//  HYKJ
//
//  Created by information on 2020/9/28.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJServiceCollectionViewController.h"
#import "KJBrowseViewController.h"
#import "XLPlainFlowLayout.h"
#import "ReusableView.h"
#import "KJServiceCollectionViewCell.h"

#import <MJExtension.h>
#import "KJGroupServiceItem.h"

@interface KJServiceCollectionViewController ()

@property (strong, nonatomic)  NSArray *services;

@end

@implementation KJServiceCollectionViewController

static NSString * const reuseIdentifier = @"KJServiceCollectionViewCellID";
static NSString * const reusableHeader = @"reusableHeader";

- (instancetype)init
{
    // 流水布局
    //UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    // 每个cell的尺寸
    
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 4 * 20) / 4, ([UIScreen mainScreen].bounds.size.width - 4 * 20) / 4);
//    CGSizeMake(([UIScreen mainScreen].bounds.size.width-20) /2, ([UIScreen mainScreen].bounds.size.height-140) /3);
    // 设置cell之间的水平间距
    layout.minimumInteritemSpacing = 0;
    // 设置cell之间的垂直间距
    layout.minimumLineSpacing = 10;
    // 设置四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(layout.minimumLineSpacing, 10, 10, 10);
    
//    if (self = [super initWithCollectionViewLayout:layout]) {} return self;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KJServiceCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableHeader];
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

- (NSArray *)services {
    if (_services == nil) {
        // JSON文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"services" ofType:@"json"];
        
        // 加载JSON文件
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        // 将JSON数据转为NSArray或者NSDictionary
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *services = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            KJGroupServiceItem *groupServiceItem = [KJGroupServiceItem mj_objectWithKeyValues:dict];
            [services addObject:groupServiceItem];
        }
        _services = services;
    }
    return _services;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.services.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    KJGroupServiceItem *groupServiceItem = self.services[section];
    return groupServiceItem.servicelist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KJServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    KJGroupServiceItem *group = self.services[indexPath.section];
    KJServiceItem *item = group.servicelist[indexPath.item];
    cell.serviceItem = item;
    
    return cell;
}

#pragma mark - height for sectionHeader
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 35);
}

#pragma mark - View for sectionHeader
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    KJGroupServiceItem *group = self.services[indexPath.section];
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableHeader forIndexPath:indexPath];
        [header initText:group.header r:group.r g:group.g b:group.b];
        reusableview = header;
    }
    return reusableview;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KJGroupServiceItem *group = self.services[indexPath.section];
    KJServiceItem *item = group.servicelist[indexPath.item];
    switch (item.serviceType) {
        case ServiceTypeFangwei: // 防伪查询
            [self browseHTML:[H5URL stringByAppendingString:FangweiService]];
            break;
        case ServiceTypeShouhou: // 售后
            [self browseHTML:[H5URL stringByAppendingString:ShouhouService]];
            break;
        case ServiceTypeToushu: // 投诉
            [self browseHTML:[H5URL stringByAppendingString:ToushuService]];
            break;
        case ServiceTypeKnowledge: // 知识库
            [SVProgressHUD showInfoWithStatus:@"正在建设中,敬请期待!"];
            break;
        case ServiceTypeKefu: // 客服
            [self browseHTML:[H5URL stringByAppendingString:KefuService]];
            break;
        default:
            break;
    }
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
