//
//  ECMediaTakenView.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ECMediaTakenType) {
    ECMediaTakenTypeHot,
    ECMediaTakenTypeTakeShot,
    ECMediaTakenTypeTakeVideo,
    ECMediaTakenTypeEmoticon
};

static CGFloat const kTakenBtnLength = 80.f;


@class ECMediaTakenView;
@protocol ECMediaTakenViewProtocol <ECActionProtocol>

@optional
- (void)mediaView:(ECMediaTakenView *)view actionType:(ECMediaTakenType)type recognizer:(UIGestureRecognizer *)gr;

@end

@interface ECMediaTakenView : UIView

+ (instancetype)createWithType:(ECMediaTakenType)type;

@property (nonatomic, assign) ECMediaTakenType type;

@property (nonatomic, weak) id<ECMediaTakenViewProtocol> mediaTakenViewDelegate;

@end

NS_ASSUME_NONNULL_END
