//
//  EPCollectionViewLayout.h
//  ShoppingHome
//
//  Created by 朱建伟 on 16/7/4.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <UIKit/UIKit.h>
 

@protocol EPCollectionViewDelegate <NSObject>


@optional
/**
 *  返回Header 可选
 */
-(UIView*)collectionViewHeaderView;

/**
 *  返回Footer  可选
 */
-(UIView*)collectionViewFooterView;

/**
 *  返回 header 组头的高度高度  组头View 使用CollectionView 自带的方法实现 可选
 */
-(CGFloat)collectionView:(UICollectionView*)collectionView heightForHeaderInSection:(NSInteger)section;


/**
 *  返回 footer 组头的高度高度  组头View 使用CollectionView 自带的方法实现 可选
 */
-(CGFloat)collectionView:(UICollectionView*)collectionView heightForFooterInSection:(NSInteger)section;


/**
 *   返回 高度间隙 可选
 */
-(CGSize)collectionView:(UICollectionView *)collectionView sizeForWHSpaceInSection:(NSInteger)section;


/**
 *  返回 对应组的sectionInset 不同的组 sectionInset不一样 可选
 */
-(UIEdgeInsets)collectionView:(UICollectionView*)collectionView sectionInsetInSection:(NSInteger)section;

/**
 *  指定 对应组的 itemSize 如果单个的itemSize 超过了 最大的临界点 默认会设置成最大 可选
 */
-(CGSize)collectionView:(UICollectionView *)collectionView itemSizeForInsection:(NSInteger)section;

@end



@interface EPCollectionViewLayout : UICollectionViewLayout

/**
 *  EPCollectionViewLayoutDelegate
 */
@property(nonatomic,weak)id<EPCollectionViewDelegate> delegate;

@end
