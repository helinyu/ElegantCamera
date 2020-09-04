//
//  ECMainView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/1.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECMainView.h"
#import "ECOperationPannelView.h"
#import "ECCameraPreviewView.h"
#import "ECCameraSettingsView.h"

static CGFloat const kOperationPannelHeight = 167.f;
static CGFloat const kDefaultPreviewRatio = (4.f/3);

@interface ECMainView ()

@property (nonatomic, strong) ECCameraSettingsView *cameraSettingsView;
@property (nonatomic, strong) ECCameraPreviewView *cameraPreviewView;
@property (nonatomic, strong) ECOperationPannelView *operationPannelView;

@property (nonatomic, assign) CGFloat previewRatio;

@end

@implementation ECMainView

- (void)baseInit {
    [super baseInit];

    self.previewRatio = kDefaultPreviewRatio;
        
    CGFloat operationViewHeight = KMWidth(kOperationPannelHeight) + XN_BOTTOM_FIX;
    
    {
         _operationPannelView = [ECOperationPannelView new];
         [self addSubview:_operationPannelView];
        [_operationPannelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.mas_equalTo(operationViewHeight);
        }];
        [_operationPannelView changeToCurIndex];
        _operationPannelView.backgroundColor = [UIColor clearColor];
     }
    
    {
        _cameraPreviewView = [ECCameraPreviewView new];
        [self addSubview:_cameraPreviewView];
        CGFloat previewHeight = self.width *self.previewRatio;
        CGFloat previewWidth = self.width;
        CGFloat previewCenterY = (self.height - operationViewHeight)/2.f;
        CGFloat centerYBottomMargin = operationViewHeight/2.f;
        if (previewHeight/2.f > previewCenterY) {
            centerYBottomMargin = (self.height - previewHeight)/2.f;
        }
        if (centerYBottomMargin <0) {
            centerYBottomMargin = 0.f;
            previewHeight = self.height;
            previewWidth = self.height/self.previewRatio;
        }
        
        [_cameraPreviewView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(-centerYBottomMargin);
            make.width.mas_equalTo(previewWidth);
            make.height.mas_equalTo(previewHeight);
        }];
        _cameraPreviewWidth = previewWidth;
        _cameraPreviewHeight = previewHeight;
//        _cameraPreviewView.backgroundColor = [UIColor redColor];
    }
    
    {
        _cameraSettingsView = [ECCameraSettingsView new];
        [self addSubview:_cameraSettingsView];
        [_cameraSettingsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(-EC_TOP_FIX);
            make.left.right.equalTo(self);
        }];
        _cameraSettingsView.backgroundColor = [UIColor clearColor];
        UIViewController *vc =  [UIApplication sharedApplication].windows.lastObject.rootViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)vc;
            vc = nav.viewControllers.lastObject;
        }
        _cameraSettingsView.cameraSettingsDelegate = (id)vc;
    }
}

@end
