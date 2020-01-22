//
//  ECSettingsBaseTCell.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/12.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECSettingsBaseTCell.h"

@interface ECSettingsBaseTCell ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *descL;

@end

@implementation ECSettingsBaseTCell

- (void)baseInit {
    [super baseInit];
    
    UIView *selectedBgView = [UIView new];
    selectedBgView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = selectedBgView;
    
    _titleL = [UILabel new];
    _descL = [UILabel new];
    [self.contentView addSubview:_titleL];
    [self.contentView addSubview:_descL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).offset(KMWidth(14.f));
    }];
    _titleL.font = HJTFont(16.f);
    _titleL.textColor = kRGB_33;
    
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).offset(KMWidth(14.f));
    }];
    _descL.font = HJTFont(13.f);
    _descL.textColor = kRGB_66;
}

- (void)setItem:(ECSettingsModel *)item {
    _item = item;
    
    self.titleL.text = item.name;
    self.descL.text = item.desc;
}


@end
