//
//  ECSettingsCircleSelectTCell.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/12.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECSettingsCircleSelectTCell.h"

@interface ECSettingsCircleSelectTCell ()

@property (nonatomic, strong) UIButton *circleBtn;
@property (nonatomic, strong) UIImageView *circleImgView;

@end

@implementation ECSettingsCircleSelectTCell

- (void)baseInit {
    [super baseInit];
    
    _circleImgView = [UIImageView new];
    [self.contentView addSubview:_circleImgView];
    [_circleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.contentView);
           make.right.equalTo(self.contentView).offset(-KMWidth(30.f));
           make.width.height.mas_equalTo(KMWidth(30.f));
    }];
    _circleImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    _circleBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview: _circleBtn];
    [_circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.circleImgView);
    }];
    
    [_circleBtn addTarget:self action:@selector(onCircleAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onCircleAction:(id)sender {
    if ([self.actionDelegate respondsToSelector:@selector(obj:actionWithParams:)]) {
        [self.actionDelegate obj:self actionWithParams:nil];
    }
}

- (void)setItem:(ECSettingsModel *)item {
    [super setItem:item];
    
    if ([item.content boolValue]) {
        _circleImgView.image =[UIImage imageNamed:@"icon_circle_selected30"];
    }
    else {
        _circleImgView.image =[UIImage imageNamed:@"icon_circle_unselected30"];
    }
}


@end
