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
    
    W_S;
    [[_circleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([weakSelf.actionDelegate respondsToSelector:@selector(obj:actionWithParams:)]) {
            [weakSelf.actionDelegate obj:self actionWithParams:nil];
        }
    }];
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
