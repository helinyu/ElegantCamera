//
//  ECTakenEmoctionView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECTakenEmoctionView.h"

@interface ECTakenEmoctionView ()

@end

@implementation ECTakenEmoctionView

+ (instancetype)createWithType:(ECMediaTakenType)type {
    return [ECTakenEmoctionView new];
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
