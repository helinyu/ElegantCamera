//
//  ECTakenVideoView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECTakenVideoView.h"

@interface ECTakenVideoView ()

@end

@implementation ECTakenVideoView

+ (instancetype)createWithType:(ECMediaTakenType)type {
    return [ECTakenVideoView new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
}

@end
