//
//  GKNewNavBarView.h
//  GKiOSApp
//
//  Created by wangws1990 on 2019/5/28.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKNewNavBarView : UIView
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

NS_ASSUME_NONNULL_END
