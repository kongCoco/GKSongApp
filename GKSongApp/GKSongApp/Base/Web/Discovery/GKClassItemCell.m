//
//  GKClassItemCell.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKClassItemCell.h"
@interface GKClassItemCell()
@property (assign, nonatomic) CGSize size;
@end
@implementation GKClassItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setClassModel:(GKHomeClassModel *)classModel{
    if (_classModel != classModel) {
        _classModel = classModel;
        self.titleLab.text = classModel.title ?:@"";
        self.nickNameLab.text = classModel.nickname ?:@"";
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:classModel.coverMiddle] placeholderImage:placeholders];
    }
}
//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
//    self.classModel.size = size;
//    CGRect cellFrame = layoutAttributes.frame;
//    cellFrame.size.height = size.height;
//    layoutAttributes.frame = cellFrame;
//    return layoutAttributes;
//}
@end

