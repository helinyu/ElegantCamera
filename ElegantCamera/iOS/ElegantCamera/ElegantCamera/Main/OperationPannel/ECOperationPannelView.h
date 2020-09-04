//
//  ECOperationPannelView.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/1.
//  Copyright © 2019 Aka. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@class ECMediaTakenView;
@class LGButton;

typedef NS_ENUM(NSUInteger, ECMainPhotoType) {
    ECMainPhotoTypeEditorPhoto =0,
    ECMainPhotoTypeFilter,
    ECMainPhotoTypePhotoTaken,
    ECMainPhotoTypeBeauty,
    ECMainPhotoTypeSticker,
    ECMainPhotoTypeBack,
    ECMainPhotoTypeShare,
    ECMainPhotoTypeSavePhoto,
};

@interface ECOperationPannelView : ECBaseView

@property (nonatomic, strong, readonly) ECMediaTakenView *takenView;

@property (nonatomic, weak) id<ECActionProtocol> pannelDelegate;

@property (nonatomic, strong, readonly) LGButton *saveBtn;

- (void)changeToCurIndex;

@end

NS_ASSUME_NONNULL_END
