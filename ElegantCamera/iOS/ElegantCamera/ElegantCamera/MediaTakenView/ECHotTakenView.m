//
//  ECHotTakenView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECHotTakenView.h"
#import "UIView+ECAdd.h"
#import "ECTakenViewHeader.h"

@interface ECHotTakenView ()

@property (nonatomic, strong) UIView *largerView;
@property (nonatomic, strong) UIView *smallView;

@end

@implementation ECHotTakenView

+ (instancetype)createWithType:(ECMediaTakenType)type {
    return [ECHotTakenView new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    _largerView = [UIView new];
    _smallView = [UIView new];
    [self addSubviews:@[_largerView, _smallView]];
    [_largerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.height.mas_equalTo(KMWidth(kTakenViewLength));
    }];
    _largerView.backgroundColor = kRGB_MAIN;
    _largerView.layer.cornerRadius = KMWidth(kTakenViewLength);
    _largerView.layer.masksToBounds = YES;
    
    [_smallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.largerView).insets(UIEdgeInsetsMake(KMWidth(kHotTakenLoopWidth), KMWidth(kHotTakenLoopWidth), KMWidth(kHotTakenLoopWidth), KMWidth(kHotTakenLoopWidth)));
    }];
    _largerView.layer.cornerRadius = KMWidth(kTakenViewLength);
    _largerView.layer.masksToBounds = YES;
}

@end
