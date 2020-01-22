//
//  XNGradientView.h
//  xndm_proj
//
//  Created by Linfeng Song on 2019/5/24.
//  Copyright © 2019 Linfeng Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECGradientView : UIView

@property(nonatomic, strong)NSArray *colors;
@property(nonatomic, strong)NSArray *locations;
@property(nonatomic, assign)CGPoint startPoint;
@property(nonatomic, assign)CGPoint endPoint;

-(void)setGradientColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

