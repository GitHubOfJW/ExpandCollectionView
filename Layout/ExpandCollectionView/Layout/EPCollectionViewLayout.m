//
//  EPCollectionViewLayout.m
//  ShoppingHome
//
//  Created by 朱建伟 on 16/7/4.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import "EPCollectionViewLayout.h"
@interface EPCollectionViewLayout()
/**
 *  headerView
 */
@property(nonatomic,strong)UIView* headerView;

/**
 *  footerView
 */
@property(nonatomic,strong)UIView* footerView;



/**
 *  最大特Y
 */
@property(nonatomic,assign)CGRect preRect;


/**
 *  attrs
 */
@property(nonatomic,strong)NSMutableArray* m_attrs;

/**
 *  sectionInsetArray
 */
@property(nonatomic,strong)NSMutableArray* m_sectionInsets;

/**
 *  itmeSizeS
 */
@property(nonatomic,strong)NSMutableArray* m_itemSizes;

/**
 *  lineSpace
 */
@property(nonatomic,strong)NSMutableArray* m_lineSpaces;

@end

@implementation EPCollectionViewLayout

/**
 *  初始化
 */
-(instancetype)init
{
    if (self = [super init ]) {
        self.preRect = CGRectZero;
    }
    return self;
}

/**
 *   开始布局
 */
-(void)prepareLayout
{
    [super prepareLayout];
    
    
    //1.设置CollectionView的Header
    BOOL isNotNullDelegate  = self.delegate?YES:NO;//是否设置了代理
    
    
    self.preRect = CGRectZero;
    [self.m_itemSizes removeAllObjects];
    [self.m_sectionInsets removeAllObjects];
    [self.m_attrs removeAllObjects];
    [self.m_lineSpaces removeAllObjects];
    
    // 判断有没有实现
    if (isNotNullDelegate&&[self.delegate respondsToSelector:@selector(collectionViewHeaderView)]) {
        UIView* headerView = [self.delegate collectionViewHeaderView];//获取头部View
        if ((headerView&&![headerView isEqual:self.headerView])||(self.headerView==nil&&headerView)){
            [self.headerView removeFromSuperview];//清楚之前的header
            self.headerView = headerView;
            CGRect headerRect = self.headerView.frame;
            headerRect.origin.x = 0;
            headerRect.origin.y = 0;
            headerRect.size.width = self.collectionView.bounds.size.width;
            self.headerView.frame = headerRect;
            self.preRect = headerRect;
            [self.collectionView addSubview:self.headerView];
        }
    }
    
    //2.设置collectionView 的SectionHeader  sectionFooter  item
    
    //sectioinHeader
    BOOL isImpHeaderheightMethod = isNotNullDelegate&&[self.delegate respondsToSelector:@selector(collectionView:heightForHeaderInSection:)];//是否实现了sectionHeader 高度
    //sectionFooter
    BOOL isImpFooterheightMethod = isNotNullDelegate&&[self.delegate respondsToSelector:@selector(collectionView:heightForFooterInSection:)]; ////是否实现了sectionHeader 高度
    
    //获取 对应的section下的 个数
    NSInteger sectionCount =  self.collectionView.numberOfSections;
    
    
    //遍历item
    for (NSUInteger section = 0; section<sectionCount; section++) {
        
        //获取行高间距
        CGSize Space =  CGSizeMake(0, 0);
        if (isNotNullDelegate&&[self.delegate respondsToSelector:@selector(collectionView:sizeForWHSpaceInSection:)]) {
            Space =  [self.delegate collectionView:self.collectionView sizeForWHSpaceInSection:section];
        }
        
        [self.m_lineSpaces addObject:[NSValue valueWithCGSize:Space]];
        
        
        //获取sectionInset
        UIEdgeInsets sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        if (isNotNullDelegate&&[self.delegate respondsToSelector:@selector(collectionView:sectionInsetInSection:)]) {
            sectionInset = [self.delegate collectionView:self.collectionView sectionInsetInSection:section];
        }
        [self.m_sectionInsets addObject: [NSValue valueWithUIEdgeInsets:sectionInset]];
        
        
        //获取ItemSize
        CGSize itemSize = CGSizeMake(0, 0);
        if (self.delegate&&[self.delegate respondsToSelector:@selector(collectionView:itemSizeForInsection:)]) {
            itemSize =[self.delegate collectionView:self.collectionView itemSizeForInsection:section];
        }
        [self.m_itemSizes addObject:[NSValue valueWithCGSize:itemSize]];
        

        
        //sectionHeader
        if (isImpHeaderheightMethod) {
            UICollectionViewLayoutAttributes * headAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            [self.m_attrs addObject:headAttr];
        }
        
        
        //item   每个选项的
        NSInteger itemCount =  [self.collectionView numberOfItemsInSection:section];
        for (NSUInteger itemIndex=0; itemIndex<itemCount; itemIndex++) {
            UICollectionViewLayoutAttributes *itemAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:section]];
            [self.m_attrs addObject:itemAttr];
        }
        
        
        //sectionFooter
        if (isImpFooterheightMethod) {
            UICollectionViewLayoutAttributes * footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            [self.m_attrs addObject:footerAttr];
        }

    }
    
    // 判断有没有实现
    if (isNotNullDelegate&&[self.delegate respondsToSelector:@selector(collectionViewFooterView)]) {
        UIView* footerView  = [self.delegate collectionViewFooterView];//获取头部View
        if ((footerView&&![footerView isEqual:self.footerView])||(self.footerView==nil&&footerView)){
            [self.footerView removeFromSuperview];//清楚之前的header
            self.footerView = footerView;
            CGRect footerRect = self.footerView.frame;
            footerRect.origin.x = 0;
            footerRect.origin.y = CGRectGetMaxY(self.preRect);;
            footerRect.size.width = self.collectionView.bounds.size.width;
            self.footerView.frame = footerRect;
            self.preRect = footerRect;
            [self.collectionView addSubview:self.footerView];
        }
    }

}

/**
 *  返回attr数组
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.m_attrs;
}

/**
 *  bounds改变需不需要刷新
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  返回CollectionSize
 */
-(CGSize)collectionViewContentSize
{
    return  CGSizeMake(self.collectionView.bounds.size.width, CGRectGetMaxY(self.preRect));//
}

/**
 *  返回CollectionView 的 sectionHeader 或者 sectionFooter的属性
 */
-(UICollectionViewLayoutAttributes*)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    
    UIEdgeInsets sectionInset =  [[self.m_sectionInsets objectAtIndex:indexPath.section] UIEdgeInsetsValue];
    
    
    
    CGFloat attrX = 0;
    CGFloat attrY = CGRectGetMaxY(self.preRect);
    
    CGFloat height =  0;
    
    CGFloat addValue = 0;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(collectionView:heightForHeaderInSection:)]) {
            height =  [self.delegate collectionView:self.collectionView heightForHeaderInSection:indexPath.section];
        }
        addValue =  sectionInset.top;
    }else{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(collectionView:heightForFooterInSection:)]) {
            height =  [self.delegate collectionView:self.collectionView heightForFooterInSection:indexPath.section];
        } 
        attrY+=sectionInset.bottom;
    }
    

    CGFloat attrW = self.collectionView.bounds.size.width;
    CGFloat attrH = height;
    
    self.preRect= CGRectMake(0,attrY+height+addValue,0,0);
    
    attr.frame = CGRectMake(attrX, attrY, attrW, attrH);
    
    return attr;

}

/**
 *  返回CollectionView 的 item
 */
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
 
    CGSize itemSize =  [[self.m_itemSizes objectAtIndex:indexPath.section] CGSizeValue];
    CGSize space = [[self.m_lineSpaces objectAtIndex:indexPath.section] CGSizeValue];
    
    CGFloat attrX = CGRectGetMaxX(self.preRect)+space.width;
    CGFloat attrY = self.preRect.origin.y;
    
    UIEdgeInsets sectionInset =  [[self.m_sectionInsets objectAtIndex:indexPath.section] UIEdgeInsetsValue];
    
    
    CGFloat attrW = itemSize.width;
    if (attrX == space.width) {//每一行的第一个
        attrX = sectionInset.left;
    }else if (attrX+attrW>self.collectionView.bounds.size.width-sectionInset.right) {//如果超出了最右边 x 变为最左侧 y 下移动
        attrX = sectionInset.left;
        attrY = CGRectGetMaxY(self.preRect)+space.height;
    }
    
    CGFloat attrH = itemSize.height;
    
    CGRect rect  = CGRectMake(attrX, attrY, attrW, attrH);
    
    self.preRect =  rect;
    attr.frame = rect;
    
    return attr;
}

/**
 *  数组
 */
-(NSMutableArray *)m_attrs
{
    if (_m_attrs==nil) {
        _m_attrs = [NSMutableArray array];
    }
    return _m_attrs;
}

/**
 *  数组
 */
-(NSMutableArray *)m_sectionInsets
{
    if (_m_sectionInsets ==nil) {
        _m_sectionInsets = [NSMutableArray array];
    }
    return _m_sectionInsets;
}

/**
 *  数组
 */
-(NSMutableArray *)m_itemSizes
{
    if (_m_itemSizes==nil) {
        _m_itemSizes = [NSMutableArray array];
    }
    return _m_itemSizes;
}

/**
 *  lineSpaceArray
 */
-(NSMutableArray *)m_lineSpaces
{
    if (_m_lineSpaces==nil) {
        _m_lineSpaces = [NSMutableArray array];
    }
    return _m_lineSpaces;
}
@end
