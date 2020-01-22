//
//  UIView+ECAdd.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "UIView+ECAdd.h"

@implementation UIView (ECAdd)

- (void)addSubviews:(NSArray<UIView *> *)subViews {
    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:[UIView class]]) {
            [self addSubview:subView];
        }
    }
}

@end
