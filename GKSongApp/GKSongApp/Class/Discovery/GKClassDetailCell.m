//
//  GKClassDetailCell.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/6.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "GKClassDetailCell.h"

@implementation GKClassDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.indexBtn.userInteractionEnabled = NO;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(GKClassTrackModel *)model{
    if (_model != model) {
        _model = model;
        self.titleLab.text= model.title ?:@"";
        self.subTitleLab.text = model.nickname ?:@"";
        [self.indexBtn setTitle:[NSString stringWithFormat:@"%@",@(self.indexPath.row+1)] forState:UIControlStateNormal];
    }
}
@end
