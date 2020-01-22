//
//  ECTakenManger.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AVCaptureVideoPreviewLayer;

@interface ECTakenManger : NSObject

+ (instancetype)single;

- (void)configBaseVariables;

@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *previewLayer;

- (void)toggleCemera;

@end

// 权限问题
@interface ECTakenManger (authorization)

- (void)requestAuthorization:(BOOLBlock)then;

@end


@interface ECTakenManger (Photo)

- (void)takePhoto:(ImgInfoBlock)then;

@end


@interface ECTakenManger (Video)

@end

@interface ECTakenManger (ShortVideo)



@end

@interface ECTakenManger (LongVideo)

@end

NS_ASSUME_NONNULL_END
