//
//  ECSettingsRightArrowTCell.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/12.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECSettingsRightArrowTCell.h"

@interface ECSettingsRightArrowTCell ()

@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation ECSettingsRightArrowTCell

- (void)baseInit {
    [super baseInit];
    
    _arrowImgView = [UIImageView new];
    [self.contentView addSubview:_arrowImgView];
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-KMWidth(20.f));
    }];
    _arrowImgView.image = [UIImage imageNamed:@"icon_right_arrow20"];
}

- (void)setItem:(ECSettingsModel *)item {
    [super setItem:item];
   
}

@end
