//
//  ECIconDescControl.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/8.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECIconDescControl.h"
#import "UIView+ECAdd.h"

@interface ECIconDescControl ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *descL;
@property (nonatomic, strong) UIButton *coverBtn;

@end

@implementation ECIconDescControl

- (void)baseInit {
    [super baseInit];
    
    _iconView = [UIImageView new];
    _descL = [UILabel new];
    _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubviews:@[_iconView, _descL, _coverBtn]];
    
//    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.mas_centerY);
//    }];
//    _descL.font = HJTFont(14.f);
//    _descL.textAlignment = NSTextAlignmentCenter;
//    _descL.textColor = UIColorHex(#1296db);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY);
        make.centerX.equalTo(self);
    }];
    
    [_coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)configIconName:(NSString *)iconName desc:(NSString *)desc {
    _iconView.image = [UIImage imageNamed:iconName];
    _descL.text = desc;
}

@end
