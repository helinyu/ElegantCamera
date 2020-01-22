//
//  WSProgressHUD.h
//  WSProgressHUD
//
//  Created by Wilson-Yuan on 15/7/17.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WSProgressHUDMaskType) {
    WSProgressHUDMaskTypeDefault, //allow user touch when hud display
    WSProgressHUDMaskTypeClear, //dont allowed user touch
    WSProgressHUDMaskTypeBlack, //dont allowed user touch
    WSProgressHUDMaskTypeGradient //dont allowed user touch
};

typedef NS_ENUM(NSInteger, WSProgressHUDMaskWithoutType) { //
    WSProgressHUDMaskWithoutDefault, // default mask all
    WSProgressHUDMaskWithoutNavigation, //show mask without navigation
    WSProgressHUDMaskWithoutTabbar, //show mask without tabbar
    WSProgressHUDMaskWithoutNavAndTabbar, //show mask without tabbar and navigation
};

typedef NS_ENUM(NSInteger, WSProgressHUDIndicatorStyle) {
    WSProgressHUDIndicatorCustom,
    WSProgressHUDIndicatorMMSpinner,
    WSProgressHUDIndicatorSmallLight,
    WSProgressHUDIndicatorGray,
    WSProgressHUDIndicatorBigGray,
};


/**
 hud的位置

 - WSProgressHUDAlignmentTop: 屏幕的上部
 - WSProgressHUDAlignmentCenter: 屏幕的中部
 - WSProgressHUDAlignmentBottom: 屏幕的下部
 */
typedef NS_ENUM(NSInteger, WSProgressHUDAlignment) {
    WSProgressHUDAlignmentTop,
    WSProgressHUDAlignmentCenter,
    WSProgressHUDAlignmentBottom,
};


typedef NS_ENUM(NSInteger, WSProgressHUDLoadingType) {
    WSProgressHUDLoadingTypeNormal, //有底框
    WSProgressHUDLoadingTypeClear,  //没有底框
};


@interface WSProgressHUD : UIView

/*----------------------Show On the Window------------------------------*/
+ (void)show;
+ (void)showWithMaskType: (WSProgressHUDMaskType)maskType;
+ (void)showWithMaskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;


+ (void)showWithStatus: (NSString *)string;
+ (void)showWithStatus: (NSString *)string maskType: (WSProgressHUDMaskType)maskType;
+ (void)showWithStatus: (NSString *)string maskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;


+ (void)showShimmeringString: (NSString *)string;
+ (void)showShimmeringString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType;
+ (void)showShimmeringString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;

+ (void)showProgress:(CGFloat)progress;
+ (void)showProgress:(CGFloat)progress maskType:(WSProgressHUDMaskType)maskType;
+ (void)showProgress:(CGFloat)progress maskType:(WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;

+ (void)showProgress:(CGFloat)progress status:(NSString*)string;
+ (void)showProgress:(CGFloat)progress status:(NSString*)string maskType:(WSProgressHUDMaskType)maskType;
+ (void)showProgress:(CGFloat)progress status:(NSString*)string maskType:(WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;

//imageSize is 28*28
+ (void)showImage:(UIImage *)image status:(NSString *)title;
+ (void)showImage:(UIImage *)image status:(NSString *)title maskType: (WSProgressHUDMaskType)maskType;
+ (void)showImage:(UIImage *)image status:(NSString *)title maskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;

//默认中部显示
+ (void)showMessage:(NSString *)message; //中部位置显示
+ (void)showBottomMessage:(NSString *)message;  //显示底部位置
+ (void)showMessage:(NSString *)message alignment:(WSProgressHUDAlignment)alignment;

+ (void)showSuccessMessage: (NSString *)string;
+ (void)showErrorMessage: (NSString *)string;
+ (void)dismiss;


//加框框处理
+ (void)showLoading; //默认为normal
+ (void)showLoading:(WSProgressHUDLoadingType)loadingType;
+ (void)showLoading:(WSProgressHUDLoadingType)loadingType maskType:(WSProgressHUDMaskType)maskType;


/*----------------------------Custom---------------------------------*/

+ (void)setProgressHUDIndicatorStyle: (WSProgressHUDIndicatorStyle)style;

/// if you set WSProgressHUDIndicatorBigGray style you should set second prority indicator Style
+ (void)setSecondProrityIndicatorStyle: (WSProgressHUDIndicatorStyle)style; //Default is small SmallLight

+ (void)setProgressHUDFont: (UIFont *)font;

/*----------------------Show On the view------------------------------*/

- (instancetype)initWithView: (UIView *)view;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)show;
- (void)showWithMaskType: (WSProgressHUDMaskType)maskType;

- (void)showWithString: (NSString *)string;
- (void)showWithString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType;
- (void)showWithString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType loadingType:(WSProgressHUDLoadingType)loadingType;


- (void)showShimmeringString: (NSString *)string;
- (void)showShimmeringString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType;

- (void)showProgress:(CGFloat)progress;
- (void)showProgress:(CGFloat)progress maskType:(WSProgressHUDMaskType)maskType;

- (void)showProgress:(CGFloat)progress status:(NSString*)status;
- (void)showProgress:(CGFloat)progress status:(NSString*)status maskType:(WSProgressHUDMaskType)maskType;

- (void)showImage:(UIImage *)image status:(NSString *)title;
- (void)showImage:(UIImage *)image status:(NSString *)title maskType: (WSProgressHUDMaskType)maskType;
- (void)showImage:(UIImage *)image status:(NSString *)title maskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType alignment:(WSProgressHUDAlignment)alignment;

- (void)showSuccessWithString: (NSString *)string;
- (void)showErrorWithString: (NSString *)string;
+ (void)showForceErrorMessage:(NSString *)string; // 不展示唯一性

- (void)dismiss;

/*----------------------------Custom---------------------------------*/
- (void)setProgressHUDIndicatorStyle: (WSProgressHUDIndicatorStyle)style;

/// if you set WSProgressHUDIndicatorBigGray style you should set second prority indicator Style
- (void)setSecondProrityIndicatorStyle: (WSProgressHUDIndicatorStyle)style; //Default is small SmallLight

- (void)setProgressHUDFont: (UIFont *)font;

@end
