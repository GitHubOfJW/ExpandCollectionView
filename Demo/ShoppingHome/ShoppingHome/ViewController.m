//
//  ViewController.m
//  ShoppingHome
//
//  Created by 朱建伟 on 16/7/4.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "ShopCell.h"
#import "ShopHeaderOrFooterView.h"
#import "EPCollectionViewLayout.h"
#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,EPCollectionViewDelegate>
/**
 *  layout
 */
@property(nonatomic,strong)EPCollectionViewLayout* layout;

/**
 *  collectionView
 */
@property(nonatomic,strong)UICollectionView* collectionView;
@end

@implementation ViewController

static  NSString* const  cellIdentifier = @"cell";
static  NSString* const  HeadOrFootIdentifier = @"headOrFoot";

/**
 *  加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[ShopCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[ShopHeaderOrFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadOrFootIdentifier];
    [self.collectionView registerClass:[ShopHeaderOrFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HeadOrFootIdentifier];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ReloadData" style:(UIBarButtonItemStyleDone) target:self action:@selector(reloadData)];
    
}


-(void)reloadData
{
    [self.collectionView reloadData];
}

#pragma mark  CollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 4;
            break;
        case 3:
            return 4;
            break;
        default:
            return 2;
            break;
    }
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell  =  [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.content =  [NSString stringWithFormat:@"第%zd组，第%zd个item",indexPath.section,indexPath.item];
    return cell;
}


-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ShopHeaderOrFooterView * headOrFootView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeadOrFootIdentifier forIndexPath:indexPath];
    headOrFootView.content = [NSString stringWithFormat:@"第%zd组，%@",indexPath.section,kind];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        headOrFootView.backgroundColor = [UIColor purpleColor];
        switch (indexPath.section) {
            case 0:
                headOrFootView.content =@"乐抢惠";
                break;
            case 1:
                headOrFootView.content =@"";
                break;
            case 2:
                headOrFootView.content =@"品质家具";
                break;
            case 3:
                headOrFootView.content =@"热卖爆款";
                break;
            default:
                headOrFootView.content =@"";
                break;
        }

    }else
    {
        headOrFootView.backgroundColor = [UIColor redColor];
    }
        return headOrFootView;
}



#pragma mark  EPCollectionViewDelegate
/**
 *  返回Header
 */
-(UIView*)collectionViewHeaderView
{
    UILabel* headerView  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    headerView.text = @"头部广告,没有则返回nil";
    headerView.font = [UIFont systemFontOfSize:20];
    headerView.textColor = [UIColor whiteColor];
    headerView.textAlignment = NSTextAlignmentCenter;
    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

/**
 *  返回Footer
 */
-(UIView*)collectionViewFooterView
{
    UILabel* footerView  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    footerView.text = @"底部的Footer，没有则返回nil";
    footerView.font = [UIFont systemFontOfSize:20];
    footerView.textColor = [UIColor whiteColor];
    footerView.textAlignment = NSTextAlignmentCenter;
    footerView.backgroundColor = [UIColor blueColor];
    return footerView;
}

/**
 *  返回 header 组头的高度高度  组头View 使用CollectionView 自带的方法实现
 */
-(CGFloat)collectionView:(UICollectionView*)collectionView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 50;
            break;
        case 1:
            return 0;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 50;
            break;
        default:
            return 50;
            break;
    }
}


/**
 *  返回 footer 组头的高度高度  组头View 使用CollectionView 自带的方法实现
 */
-(CGFloat)collectionView:(UICollectionView*)collectionView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


/**
 *   返回 高度间隙
 */
-(CGSize)collectionView:(UICollectionView *)collectionView sizeForWHSpaceInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return CGSizeMake(2, 5);
            break;
        case 1:
            return CGSizeMake(0, 5);
            break;
        case 2:
            return CGSizeMake(0, 5);
            break;
        case 3:
            return CGSizeMake(15,5);
            break;
        default:
            return CGSizeMake(10, 10);
            break;
    }

    
}


/**
 *  返回 对应组的sectionInset 不同的组 sectionInset不一样
 */
-(UIEdgeInsets)collectionView:(UICollectionView*)collectionView sectionInsetInSection:(NSInteger)section
{
    CGFloat left=0,right  =0;
    CGFloat top=5,bottom = 5;
    switch (section) {
        case 0:
            break;
        case 1:
            top = 0;
            break;
        case 2:
            
            break;
        case 3:
            left=15;
            right=15;
            break;
        default:
            
            break;
    }
    return UIEdgeInsetsMake(top, left, bottom, right);
}

/**
 *  指定 对应组的 itemSize 如果单个的itemSize 超过了 最大的临界点 默认会设置成最大
 */
-(CGSize)collectionView:(UICollectionView *)collectionView itemSizeForInsection:(NSInteger)section
{
    UIEdgeInsets sectionInset   =  [self collectionView:collectionView sectionInsetInSection:section];
    CGSize  space =  [self collectionView:collectionView sizeForWHSpaceInSection:section];
    
    CGFloat height  = 100;
    
    CGFloat width = 0;
    switch (section) {
        case 0:
            width  = (collectionView.bounds.size.width-sectionInset.left-sectionInset.right-space.width)/2;
            height=width;
            break;
        case 1:
            width = collectionView.bounds.size.width-sectionInset.left-sectionInset.right-space.width;
            break;
        case 2:
            width = collectionView.bounds.size.width-sectionInset.left-sectionInset.right-space.width;
            break;
        case 3:
            width  = (collectionView.bounds.size.width-sectionInset.left-sectionInset.right-space.width)/2;
            height=width;
            break;
        default:
            width = 100;
            break;
    }
    return  CGSizeMake(width, height);
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.collectionView];
}

/**
 *  布局
 */
-(EPCollectionViewLayout *)layout
{
    if (_layout ==nil) {
        _layout =  [[EPCollectionViewLayout alloc] init];
        _layout.delegate =self;
    }
    return _layout;
}

-(UICollectionView *)collectionView
{
    if (_collectionView ==nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource=self;
        
    }
    return _collectionView;
}
@end
