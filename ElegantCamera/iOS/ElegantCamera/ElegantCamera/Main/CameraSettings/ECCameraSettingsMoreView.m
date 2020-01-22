//
//  ECCameraSettingsMoreView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/8.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECCameraSettingsMoreView.h"
#import "ECIconDescControl.h"
#import "UIView+ECAdd.h"


@interface ECCameraSettingsMoreView ()

@property (nonatomic, strong) UIView *contentTextView;

//80
@property (nonatomic, strong) ECIconDescControl *touchTakenCtrl;
@property (nonatomic, strong) ECIconDescControl *delayTakenCtrl;
@property (nonatomic, strong) ECIconDescControl *flashLampCtrl;
@property (nonatomic, strong) ECIconDescControl *networkLatticeCtrl;
@property (nonatomic, strong) ECIconDescControl *settingsCtrl;

//1
@property (nonatomic, strong) UIView *topLineView;

//80
@property (nonatomic, strong) UILabel *autoSaveL;
@property (nonatomic, strong) UISwitch *autoSwitchBtn;

//1
@property (nonatomic, strong) UIView *bottomView;

// 80
@property (nonatomic, strong) UILabel *nightModeL;
@property (nonatomic, strong) UISwitch *nightSwitch;

@end

static CGFloat const kMoreTotalHeight = 242.f;
static CGFloat const kMoreTotalWidth = 320.f;
static CGFloat const kMoreALLWidth = 340.f;
static CGFloat const kMoreLeftMargin = 10.f;


@implementation ECCameraSettingsMoreView

- (void)setInterFace {
    [super setInterFace];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(KMWidth(70.f));
        make.centerX.equalTo(self);
    }];
    self.contentView.backgroundColor = kRGB_FF;
    self.contentView.layer.cornerRadius = KMWidth(10.f);
    self.contentView.layer.masksToBounds = YES;
    
    _contentTextView = [UIView new];
    [self.contentView addSubview:_contentTextView];
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(KMWidth(kMoreLeftMargin));
        make.right.equalTo(self.contentView).offset(-KMWidth(kMoreLeftMargin));
        make.width.mas_equalTo(KMWidth(kMoreTotalWidth));
        make.height.mas_equalTo(KMWidth(kMoreTotalHeight));
    }];
    
    //80
    _touchTakenCtrl = [ECIconDescControl new];
    _delayTakenCtrl = [ECIconDescControl new];
    _flashLampCtrl = [ECIconDescControl new];
    _flashLampCtrl = [ECIconDescControl new];
    _networkLatticeCtrl = [ECIconDescControl new];
    _settingsCtrl = [ECIconDescControl new];
    [self.contentTextView addSubviews:@[_touchTakenCtrl, _delayTakenCtrl, _flashLampCtrl, _networkLatticeCtrl, _settingsCtrl]];
    CGFloat ctrlWidth = KMWidth(kMoreTotalWidth)/5.f;
    [_touchTakenCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentTextView);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(ctrlWidth);
        make.height.mas_equalTo(KMWidth(80.f));
    }];
    [_touchTakenCtrl configIconName:@"icon_settings_more_touch" desc:@"触摸拍摄"];
     
    [_delayTakenCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.touchTakenCtrl.mas_right);
          make.top.equalTo(self.contentView);
          make.width.mas_equalTo(ctrlWidth);
          make.height.mas_equalTo(KMWidth(80.f));
      }];
    [_delayTakenCtrl configIconName:@"icon_settings_more_delay" desc:@"延迟拍摄"];
    
    [_flashLampCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.delayTakenCtrl.mas_right);
          make.top.equalTo(self.contentView);
          make.width.mas_equalTo(ctrlWidth);
          make.height.mas_equalTo(KMWidth(80.f));
      }];
    [_flashLampCtrl configIconName:@"icon_settings_more_flashdump" desc:@"闪光灯"];

    [_networkLatticeCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.flashLampCtrl.mas_right);
          make.top.equalTo(self.contentView);
          make.width.mas_equalTo(ctrlWidth);
          make.height.mas_equalTo(KMWidth(80.f));
      }];
    [_networkLatticeCtrl configIconName:@"icon_settings_more_net_line" desc:@"网格线"];

    [_settingsCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.networkLatticeCtrl.mas_right);
          make.top.equalTo(self.contentView);
          make.width.mas_equalTo(ctrlWidth);
          make.height.mas_equalTo(KMWidth(80.f));
      }];
    [_settingsCtrl configIconName:@"icon_settings_more_settings" desc:@"设置"];
    
    [self updateControlConstraintsWithControl:_touchTakenCtrl];
    [self updateControlConstraintsWithControl:_delayTakenCtrl];
    [self updateControlConstraintsWithControl:_flashLampCtrl];
    [self updateControlConstraintsWithControl:_networkLatticeCtrl];
    [self updateControlConstraintsWithControl:_settingsCtrl];
    
    //1
    _topLineView = [UIView new];
    [self.contentTextView addSubview:self.topLineView];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentTextView);
        make.top.equalTo(self.settingsCtrl.mas_bottom);
        make.height.mas_equalTo(1.f);
    }];
    _topLineView.backgroundColor = kRGB_DD;

    //80
    UIView *autoSaveWrapperView = [UIView new];
    [self.contentTextView addSubview:autoSaveWrapperView];
    [autoSaveWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentTextView);
        make.top.equalTo(self.topLineView.mas_bottom);
        make.height.mas_equalTo(KMWidth(80.f));
    }];
    _autoSaveL = [UILabel new];
    _autoSwitchBtn = [UISwitch new];
    [autoSaveWrapperView addSubviews:@[_autoSaveL, _autoSwitchBtn]];
    
    [_autoSaveL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(autoSaveWrapperView);
        make.left.equalTo(autoSaveWrapperView).offset(KMWidth(5.f));
    }];
    _autoSaveL.text = @"自动保存";
    _autoSaveL.font = HJTFont(14.f);
    _autoSaveL.textColor = kRGB_33;
    
    [_autoSwitchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(autoSaveWrapperView);
        make.right.equalTo(autoSaveWrapperView);
    }];
    
    //1
    _bottomView = [UIView new];
    [self.contentTextView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentTextView);
        make.height.mas_equalTo(1.f);
        make.top.equalTo(autoSaveWrapperView.mas_bottom);
    }];
    _bottomView.backgroundColor = kRGB_DD;

    // 80
    UIView *nightWrapperView = [UIView new];
    [self.contentTextView addSubview:nightWrapperView];
    [nightWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentTextView);
        make.top.equalTo(self.bottomView.mas_bottom);
    }];
    
    _nightModeL = [UILabel new];
    _nightSwitch = [UISwitch new];
    [nightWrapperView addSubviews:@[_nightModeL, _nightSwitch]];
    [_nightModeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nightWrapperView).offset(KMWidth(5.f));
        make.centerY.equalTo(nightWrapperView);
    }];
    _nightModeL.text = @"夜拍模式";
    _nightModeL.font = HJTFont(14.f);
    _nightModeL.textColor = kRGB_33;
    
    [_nightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nightWrapperView);
        make.right.equalTo(self.contentTextView).offset(-KMWidth(5.f));
    }];
    
    
    [self initBind];
}

- (void)updateControlConstraintsWithControl:(ECIconDescControl *)control {
    [control.descL mas_updateConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(control.mas_centerY).offset(KMWidth(10.f));
    }];
    [control.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(control.mas_centerY).offset(KMWidth(4.f));
    }];
}

- (void)initBind {
    self.touchTakenCtrl.coverBtn.tag = ECCameraSettingsMoreTypeTouchShoot;
    [self.touchTakenCtrl.coverBtn addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
    self.delayTakenCtrl.coverBtn.tag = ECCameraSettingsMoreTypeDelayShoot;
      [self.delayTakenCtrl.coverBtn addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
    self.flashLampCtrl.coverBtn.tag = ECCameraSettingsMoreTypeFlashLamp;
      [self.flashLampCtrl.coverBtn addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
    self.networkLatticeCtrl.coverBtn.tag = ECCameraSettingsMoreTypeNetworkLattice;
      [self.networkLatticeCtrl.coverBtn addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
    self.settingsCtrl.coverBtn.tag = ECCameraSettingsMoreTypeSettings;
      [self.settingsCtrl.coverBtn addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
    
    

- (void)onTapAction:(UIButton *)sender {
    if ([self.actionProtocol respondsToSelector:@selector(obj:actionWithParams:)]) {
        [self.actionProtocol obj:self actionWithParams:@(sender.tag)];
    }
}

@end
