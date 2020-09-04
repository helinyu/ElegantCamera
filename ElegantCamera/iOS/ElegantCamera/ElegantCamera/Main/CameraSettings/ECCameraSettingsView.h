//
//  ECCameraSettingsView.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/1.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ECCameraSettingsType) {
    ECCameraSettingsTypeNone =0,
    ECCameraSettingsTypeMore,
    ECCameraSettingsTypePreviewArea,
    ECCameraSettingsTypeToggleCamera
};

@interface ECCameraSettingsView : ECBaseView

@property (nonatomic, strong, readonly) UIButton *toggleCameraBtn;

@property (nonatomic, weak) id<ECActionProtocol> cameraSettingsDelegate;

@end

NS_ASSUME_NONNULL_END
