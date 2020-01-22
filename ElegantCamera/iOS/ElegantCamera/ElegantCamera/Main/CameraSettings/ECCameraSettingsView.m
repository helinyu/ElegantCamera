//
//  ECCameraSettingsView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/1.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECCameraSettingsView.h"
#import "UIView+ECAdd.h"

static CGFloat  const kBtnLength = 40.f;
static CGFloat  const selfHeight = 60.f;

@interface ECCameraSettingsView ()

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIButton *toggleCameraBtn;

@property (nonatomic, strong) UIButton *previewAreaBtn;

@end

@implementation ECCameraSettingsView

- (void)baseInit {
    [super baseInit];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewAreaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _toggleCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubviews:@[_moreBtn, _previewAreaBtn, _toggleCameraBtn]];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(KMWidth(20.f));
        make.width.height.mas_equalTo(KMWidth(kBtnLength));
        make.top.equalTo(self).offset(KMWidth(10.f));
        make.bottom.equalTo(self).offset(-KMWidth(10.f));
    }];
    _moreBtn.tag = ECCameraSettingsTypeMore;
    [_moreBtn setBackgroundImage:[UIImage imageNamed:@"icon_settings_more"] forState:UIControlStateNormal];

    [_previewAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
//        make.width.height.mas_equalTo(KMWidth(kBtnLength));
    }];
    _previewAreaBtn.tag = ECCameraSettingsTypePreviewArea;
    [_previewAreaBtn setTitle:@"4:3" forState:UIControlStateNormal];
    _previewAreaBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    _previewAreaBtn.layer.borderWidth = 1.f;
    _previewAreaBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _previewAreaBtn.layer.cornerRadius = 2.f;
    _previewAreaBtn.layer.masksToBounds = YES;
    [_previewAreaBtn.titleLabel sizeToFit];
    
    [_toggleCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-KMWidth(20.f));
        make.width.height.mas_equalTo(KMWidth(kBtnLength));
    }];
    _toggleCameraBtn.tag = ECCameraSettingsTypeToggleCamera;
    [_toggleCameraBtn setBackgroundImage:[UIImage imageNamed:@"icon_settings_toggle_camera"] forState:UIControlStateNormal];
    
    [_moreBtn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_previewAreaBtn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toggleCameraBtn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)onBtnAction:(UIButton *)btn {
    if ([self.cameraSettingsDelegate respondsToSelector:@selector(obj:actionWithParams:)]) {
        [self.cameraSettingsDelegate obj:self actionWithParams:@(btn.tag)];
    }
}

@end
