//
//  ECCameraSettingsMoreView.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/8.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "WKPopBaseView.h"
#import "ECActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ECCameraSettingsMoreType) {
    ECCameraSettingsMoreTypeNone =0,
    ECCameraSettingsMoreTypeTouchShoot,
    ECCameraSettingsMoreTypeDelayShoot,
    ECCameraSettingsMoreTypeFlashLamp,
    ECCameraSettingsMoreTypeNetworkLattice,
    ECCameraSettingsMoreTypeSettings,
    ECCameraSettingsMoreTypeAutoSave,
    ECCameraSettingsMoreTypeNighMode

};

@interface ECCameraSettingsMoreView : WKPopBaseView

@property (nonatomic, weak) id<ECActionProtocol> actionProtocol;

@end

NS_ASSUME_NONNULL_END
