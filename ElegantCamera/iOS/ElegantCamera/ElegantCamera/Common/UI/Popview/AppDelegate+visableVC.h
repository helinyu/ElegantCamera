//
//  AppDelegate+visableVC.h
//  KanManHua
//
//  Created by wangkun on 2017/9/25.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (visableVC)

+ (UIViewController *)getVisableVC;
+ (void)getNavVCWithBlock:(NavBlock)closure;
+ (UIView *)getVisableView;

+ (void)gotoHomeWithSelectedIndex:(NSUInteger)selectedIndex;
+ (UIViewController *)getRootViewController;

@end
