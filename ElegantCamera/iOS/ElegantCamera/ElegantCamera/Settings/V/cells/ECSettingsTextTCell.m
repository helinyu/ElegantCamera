//
//  ECSettingsTextTCell.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/12.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECSettingsTextTCell.h"

@interface ECSettingsTextTCell ()

@property (nonatomic, strong) UILabel *contentL;

@end

@implementation ECSettingsTextTCell

- (void)baseInit {
    [super baseInit];
    
    _contentL = [UILabel new];
    [self.contentView addSubview:_contentL];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-KMWidth(20.f));
        make.centerY.equalTo(self.contentView);
    }];
    _contentL.textAlignment = NSTextAlignmentRight;
    _contentL.textColor = kRGB_66;
    _contentL.font = HJTFont(13.f);
}

- (void)setItem:(ECSettingsModel *)item {
    [super setItem:item];
        
    if (item.contentType == ECSettingsContentTypeAppVersion) {
        self.descL.text = nil;
        self.contentL.text = item.desc;
    }
    else {
        float value = ((NSNumber *)item.content).integerValue;
        self.contentL.text = [NSString stringWithFormat:@"%.2fM",value];
    }
}

@end
