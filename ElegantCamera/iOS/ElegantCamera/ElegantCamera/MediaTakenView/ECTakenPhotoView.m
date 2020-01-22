//
//  ECTakenPhotoView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECTakenPhotoView.h"
#import "ECGradientView.h"

@interface ECTakenPhotoView ()

//@property (nonatomic, strong) UIButton *takenBtn;
@property (nonatomic, strong) ECGradientView *gradientView;

@end

@implementation ECTakenPhotoView

+ (instancetype)createWithType:(ECMediaTakenType)type {
    return [ECTakenPhotoView new];
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
    
    _gradientView = [ECGradientView new];
    [self insertSubview:_gradientView atIndex:0];
    [_gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
               make.width.height.mas_equalTo(KMWidth(kTakenBtnLength));
    }];
    _gradientView.layer.cornerRadius = KMWidth(kTakenBtnLength)/2.f;
    _gradientView.layer.masksToBounds = YES;
    [_gradientView setGradientColors:@[kRGB_MAIN, kRGB_MAIN_WEIGHT] locations:@[@0.1f, @0.55f, @0.9f] startPoint:CGPointMake(0.f, 1.f) endPoint:CGPointMake(1.f, 0.f)];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGRAction:)];
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onGRAction:)];
    [self.gradientView addGestureRecognizer:tapGR];
    [self.gradientView addGestureRecognizer:longPressGR];
    
}

- (void)onGRAction:(UIGestureRecognizer *)gr {
    if ([self.mediaTakenViewDelegate respondsToSelector:@selector(mediaView:actionType:recognizer:)]) {
        [self.mediaTakenViewDelegate mediaView:self actionType:ECMediaTakenTypeTakeShot recognizer:gr];
    }
}

@end
