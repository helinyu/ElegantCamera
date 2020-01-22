//
//  ECMediaTakenView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECMediaTakenView.h"

#import "ECHotTakenView.h"
#import "ECTakenPhotoView.h"
#import "ECTakenVideoView.h"
#import "ECTakenEmoctionView.h"

@interface ECMediaTakenView ()

@end

@implementation ECMediaTakenView

+ (instancetype)createWithType:(ECMediaTakenType)type {
    if (type == ECMediaTakenTypeHot) {
        return [ECHotTakenView createWithType:type];
    }
    else if (type == ECMediaTakenTypeTakeShot) {
          return [ECTakenPhotoView createWithType:type];
    }
    else if (type == ECMediaTakenTypeTakeVideo) {
          return [ECTakenVideoView createWithType:type];
    }
    else if (type == ECMediaTakenTypeEmoticon) {
          return [ECTakenEmoctionView createWithType:type];
    }
    else {
        return [self init];
    }
}

@end
