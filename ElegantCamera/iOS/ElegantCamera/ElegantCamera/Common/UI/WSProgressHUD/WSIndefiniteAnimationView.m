//
//  WSIndefiniteAnimationView.m
//  WSProgressHUD
//
//  Created by Wilson-Yuan on 15/7/19.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "WSIndefiniteAnimationView.h"


#if 1

@interface WSIndefiniteAnimationView ()

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end


@implementation WSIndefiniteAnimationView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview) {
        [self layoutAnimationLayer];
    } else {
        [_indicatorView stopAnimating];
        _indicatorView = nil;
    }
}

- (void)layoutAnimationLayer {
    [self addSubview:self.indicatorView];
    self.indicatorView.center = CGPointMake(self.width/2, self.height/2);
}

-(void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if (hidden) {
        [self.indicatorView stopAnimating];
    }
    else
    {
        [self.indicatorView startAnimating];
    }
}


- (void)setFrame:(CGRect)frame {
    if(!CGRectEqualToRect(frame, super.frame)){
        [super setFrame:frame];
        
        if (self.superview) {
            [self layoutAnimationLayer];
        }
    }
    
}


- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGAffineTransform transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        _indicatorView.transform = transform;
    }
    return _indicatorView;
}


@end

#else

@interface WSIndefiniteAnimationView ()

@property (strong, nonatomic) CAShapeLayer *indefiniteAnimatedLayer;
@property (strong, nonatomic) UIImageView * IV;

@end


@implementation WSIndefiniteAnimationView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview) {
        [self layoutAnimationLayer];
    } else {
        [_indefiniteAnimatedLayer removeFromSuperlayer];
        _indefiniteAnimatedLayer = nil;
    }
}

- (void)layoutAnimationLayer {
    CALayer *layer = self._indefiniteAnimatedLayer;
    [self.layer addSublayer:layer];
    layer.position = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds)/2, CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds) / 2);
}

- (CAShapeLayer *)_indefiniteAnimatedLayer
{
    if(!_indefiniteAnimatedLayer) {
        CGPoint arcCenter = CGPointMake(self.radius+self.strokeThickness/2+5, self.radius+self.strokeThickness/2+5);
        CGRect rect = CGRectMake(0.0f, 0.0f, arcCenter.x*1.8, arcCenter.y*1.8);
        _indefiniteAnimatedLayer = [CAShapeLayer layer];
        _indefiniteAnimatedLayer.contentsScale = [[UIScreen mainScreen] scale];
        _indefiniteAnimatedLayer.frame = rect;

        
        
//        NSBundle *bundle = [NSBundle bundleForClass:self.class];
//        NSURL *url = [bundle URLForResource:@"WSProgressBundle" withExtension:@"bundle"];
//        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
//        NSString *path = [imageBundle pathForResource:@"circle@2x" ofType:@"png"];
//        _indefiniteAnimatedLayer.contents = (id)[[UIImage imageWithContentsOfFile:path] CGImage];;
        
        UIImage *animaIC = [UIImage km_imageWithName:@"icon_hub_loading"];
        _indefiniteAnimatedLayer.contents = (id)[animaIC CGImage];;
        
        NSTimeInterval animationDuration = 1;
        CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = 0;
        animation.toValue = @(M_PI*2);
        animation.duration = animationDuration;
        animation.timingFunction = linearCurve;
        animation.removedOnCompletion = NO;
        animation.repeatCount = INFINITY;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        [_indefiniteAnimatedLayer addAnimation:animation forKey:@"rotate"];
        
//        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
//        animationGroup.duration = animationDuration;
//        animationGroup.repeatCount = INFINITY;
//        animationGroup.removedOnCompletion = NO;
//        animationGroup.timingFunction = linearCurve;
        
//        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//        strokeStartAnimation.fromValue = @0.015;
//        strokeStartAnimation.toValue = @0.515;
//        
//        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        strokeEndAnimation.fromValue = @0.485;
//        strokeEndAnimation.toValue = @0.985;
//        
//        animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
//        [_indefiniteAnimatedLayer addAnimation:animationGroup forKey:@"progress"];
        
    }
    return _indefiniteAnimatedLayer;
}


- (void)setFrame:(CGRect)frame {
    if(!CGRectEqualToRect(frame, super.frame)){
        [super setFrame:frame];
        
        if (self.superview) {
            [self layoutAnimationLayer];
        }
    }
    
}

- (void)setRadius:(CGFloat)radius {
    if(radius != _radius){
        _radius = radius;
        
        [_indefiniteAnimatedLayer removeFromSuperlayer];
        _indefiniteAnimatedLayer = nil;
        
        if (self.superview) {
            [self layoutAnimationLayer];
        }
    }
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    _indefiniteAnimatedLayer.strokeColor = strokeColor.CGColor;
}

- (void)setStrokeThickness:(CGFloat)strokeThickness {
    _strokeThickness = strokeThickness;
    _indefiniteAnimatedLayer.lineWidth = _strokeThickness;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake((self.radius+self.strokeThickness/2+5)*2, (self.radius+self.strokeThickness/2+5)*2);
}


- (UIImageView *)IV
{
    if (!_IV) {
//        NSBundle *bundle = [NSBundle bundleForClass:self.class];
//        NSURL *url = [bundle URLForResource:@"WSProgressBundle" withExtension:@"bundle"];
//        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
//        NSString *path = [imageBundle pathForResource:@"circle@3x" ofType:@"png"];
//        _IV = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        
        _IV = [[UIImageView alloc] initWithImage:[UIImage km_imageWithName:@"icon_hub_loading"]];
        [self addSubview:_IV];
    }
    return _IV;
}


@end

#endif
