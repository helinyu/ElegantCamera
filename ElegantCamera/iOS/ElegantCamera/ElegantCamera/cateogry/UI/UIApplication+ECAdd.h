//
//  UIApplication+ECAdd.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/13.
//  Copyright © 2019 Aka. All rights reserved.
//


#import <UIKit/UIKit.h>

#define kAppVersion [UIApplication appVersion]

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (ECAdd)

+ (NSString *)appVersion;

@end

NS_ASSUME_NONNULL_END
