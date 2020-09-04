//
//  ECMainView.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/1.
//  Copyright © 2019 Aka. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@class ECCameraSettingsView;
@class ECCameraPreviewView;
@class ECOperationPannelView;

@interface ECMainView : ECBaseView

@property (nonatomic, strong, readonly) ECCameraSettingsView *cameraSettingsView;

@property (nonatomic, strong, readonly) ECCameraPreviewView *cameraPreviewView;
@property (nonatomic, assign, readonly) CGFloat cameraPreviewWidth;
@property (nonatomic, assign, readonly) CGFloat cameraPreviewHeight;

@property (nonatomic, strong, readonly) ECOperationPannelView *operationPannelView;

@property (nonatomic, strong, readonly) UIButton *closeBtn;

@end

NS_ASSUME_NONNULL_END
