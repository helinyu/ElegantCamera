//
//  UIApplication+ECAdd.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/13.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "UIApplication+ECAdd.h"

@implementation UIApplication (ECAdd)

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

@end
