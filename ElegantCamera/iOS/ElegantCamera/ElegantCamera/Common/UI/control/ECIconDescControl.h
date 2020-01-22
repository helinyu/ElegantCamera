//
//  ECIconDescControl.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/8.
//  Copyright © 2019 Aka. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface ECIconDescControl : ECBaseView

@property (nonatomic, strong, readonly) UIButton *coverBtn;
- (void)configIconName:(NSString *)iconName desc:(NSString *)desc;
@property (nonatomic, strong, readonly) UILabel *descL;
@property (nonatomic, strong, readonly) UIImageView *iconView;

@end

NS_ASSUME_NONNULL_END
