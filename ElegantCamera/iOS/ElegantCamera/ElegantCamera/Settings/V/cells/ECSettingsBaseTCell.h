//
//  ECSettingsBaseTCell.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/12.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECBaseTCell.h"
#import "ECSettingsModel.h"
#import "ECActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ECSettingsBaseTCell : ECBaseTCell

@property (nonatomic, strong) ECSettingsModel *item;

@property (nonatomic, strong, readonly) UILabel *titleL;
@property (nonatomic, strong, readonly) UILabel *descL;

@property (nonatomic, weak) id<ECActionProtocol> actionDelegate;

@end

NS_ASSUME_NONNULL_END
