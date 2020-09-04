//
//  ECPreviewRatioView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/8.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECPreviewRatioView.h"
#import "UIView+ECAdd.h"
#import "ECIconDescControl.h"

@interface ECPreviewRatioView ()

@property (nonatomic, strong) ECIconDescControl *smallBoxCtrl;
@property (nonatomic, strong) UIView *leftLineView;

@property (nonatomic, strong) ECIconDescControl *ratio9_16Ctrl;
@property (nonatomic, strong) ECIconDescControl *ratio3_4Ctrl;
@property (nonatomic, strong) ECIconDescControl *ratio1_1Ctrl;
@property (nonatomic, strong) ECIconDescControl *circleCtrl;

@property (nonatomic, strong) UIView *rightLineView;
@property (nonatomic, strong) ECIconDescControl *multiSquaredCtrl;

@end

static CGFloat const kFlowWinWidth = 320.f;
static CGFloat const kFlowWinHeight = 80.f;
static CGFloat const kBtnItemWidth = 50.f;
static CGFloat const kLineTotalWidth = 10.f;
static CGFloat const kLineWidth = 1.f;

@implementation ECPreviewRatioView

- (void)setInterFace {
    [super setInterFace];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KMWidth(kFlowWinWidth));
        make.height.mas_equalTo(KMWidth(kFlowWinHeight));
        make.top.equalTo(self).offset(KMWidth(70.f));
        make.centerX.equalTo(self);
    }];
    self.contentView.layer.cornerRadius = KMWidth(10.f);
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.masksToBounds = YES;
    
    _smallBoxCtrl = [ECIconDescControl new];
    _leftLineView = [UIView new];
    _ratio9_16Ctrl = [ECIconDescControl new];
    _ratio3_4Ctrl = [ECIconDescControl new];
    _ratio1_1Ctrl = [ECIconDescControl new];
    _circleCtrl = [ECIconDescControl new];
    
    
    _rightLineView = [UIButton buttonWithType:UIButtonTypeCustom];
    _multiSquaredCtrl = [ECIconDescControl new];
    
    [self.contentView addSubviews:@[_smallBoxCtrl, _leftLineView, _ratio9_16Ctrl, _ratio3_4Ctrl, _ratio1_1Ctrl, _circleCtrl, _rightLineView, _multiSquaredCtrl]];
    
    [_smallBoxCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.bottom.top.equalTo(self.contentView);
        make.width.mas_equalTo(KMWidth(kBtnItemWidth));
    }];
    [_smallBoxCtrl configIconName:@"icon_little_box_btn" desc:@"小框"];
    
    [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1.f);
        make.left.equalTo(self.smallBoxCtrl.mas_right).offset(KMWidth((kLineTotalWidth-1)/2.f));
        make.height.mas_equalTo(KMWidth(kBtnItemWidth));
        make.centerY.equalTo(self.smallBoxCtrl);
    }];
    _leftLineView.backgroundColor = kRGB_DD;
    
    [_ratio9_16Ctrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLineView.mas_right).offset(KMWidth((kLineTotalWidth-1)/2.f));
        make.width.mas_equalTo(KMWidth(kBtnItemWidth));
        make.bottom.top.equalTo(self.contentView);
    }];
    [_ratio9_16Ctrl configIconName:@"icon_little_box_btn" desc:@"9:16"];
    
    [_ratio3_4Ctrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ratio9_16Ctrl.mas_right);
        make.width.mas_equalTo(KMWidth(kBtnItemWidth));
        make.bottom.top.equalTo(self.contentView);
    }];
    [_ratio3_4Ctrl configIconName:@"icon_little_box_btn" desc:@"3:4"];
    
    [_ratio1_1Ctrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ratio3_4Ctrl.mas_right);
        make.width.mas_equalTo(KMWidth(kBtnItemWidth));
        make.bottom.top.equalTo(self.contentView);
    }];
    [_ratio1_1Ctrl configIconName:@"icon_little_box_btn" desc:@"1:1"];
    
    [_circleCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ratio1_1Ctrl.mas_right);
        make.width.mas_equalTo(KMWidth(kBtnItemWidth));
        make.bottom.top.equalTo(self.contentView);
    }];
    [_circleCtrl configIconName:@"icon_little_box_btn" desc:@"圆形"];
    
    [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleCtrl.mas_right).offset(KMWidth((kLineTotalWidth-1)/2.f));
        make.width.mas_equalTo(1.f);
        make.height.mas_equalTo(KMWidth(kBtnItemWidth));
        make.centerY.equalTo(self.smallBoxCtrl);
    }];
    _rightLineView.backgroundColor = kRGB_DD;
    
    [_multiSquaredCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightLineView.mas_right).offset(KMWidth((kLineTotalWidth-1)/2.f));
        make.width.mas_equalTo(KMWidth(kBtnItemWidth));
        make.bottom.top.equalTo(self.contentView);
    }];
    [_multiSquaredCtrl configIconName:@"icon_little_box_btn" desc:@"多格"];
    
}

@end
