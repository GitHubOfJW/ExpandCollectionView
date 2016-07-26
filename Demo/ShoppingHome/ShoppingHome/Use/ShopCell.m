//
//  ShopCell.m
//  ShoppingHome
//
//  Created by 朱建伟 on 16/7/4.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import "ShopCell.h"
@interface ShopCell()
/**
 *  label
 */
@property(nonatomic,strong)UILabel* label;
@end
@implementation ShopCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.contentView .backgroundColor = [UIColor orangeColor];
        self.label = [[UILabel alloc] init];
        self.label.textColor =[UIColor blueColor];
        self.label.textAlignment =NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label.frame= self.bounds;
    
}

-(void)setContent:(NSString *)content
{
    if (content) {
        _content = content;
        
        self.label.text = content;
    }
}
@end
