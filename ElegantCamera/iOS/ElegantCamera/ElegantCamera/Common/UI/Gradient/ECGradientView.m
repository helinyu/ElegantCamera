//
//  XNGradientView.m
//  xndm_proj
//
//  Created by Linfeng Song on 2019/5/24.
//  Copyright © 2019 Linfeng Song. All rights reserved.
//

#import "ECGradientView.h"

@implementation ECGradientView

+(Class)layerClass {
    return [CAGradientLayer class];
}

-(void)setGradientColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    self.colors = [colorsM copy];
    self.locations = locations;
    self.startPoint = startPoint;
    self.endPoint = endPoint;
    
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        CAGradientLayer *layer = (id)self.layer;
        [layer setColors:self.colors];
        [layer setLocations:self.locations];
        [layer setStartPoint:self.startPoint];
        [layer setEndPoint:self.endPoint];
    }
}

@end
