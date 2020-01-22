//
//  ECSettingsSwitchTCell.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/12.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECSettingsSwitchTCell.h"

@interface ECSettingsSwitchTCell ()

@property (nonatomic, strong) UISwitch *switchControl;

@end

@implementation ECSettingsSwitchTCell

- (void)baseInit {
    [super baseInit];
    
    _switchControl = [UISwitch new];
    [self.contentView addSubview:_switchControl];
    [_switchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-KMWidth(20.f));
    }];
    
    W_S;
    [[_switchControl rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([weakSelf.actionDelegate respondsToSelector:@selector(obj:actionWithParams:)]) {
            [weakSelf.actionDelegate obj:self actionWithParams:nil];
        }
    }];
}

- (void)setItem:(ECSettingsModel *)item {
    [super setItem:item];
    
    BOOL selected = [item.content boolValue];
    self.switchControl.on = selected;
}

@end
