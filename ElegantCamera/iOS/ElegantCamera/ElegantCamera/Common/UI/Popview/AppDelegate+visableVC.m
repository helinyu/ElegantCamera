//
//  AppDelegate+visableVC.m
//  KanManHua
//
//  Created by wangkun on 2017/9/25.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#import "AppDelegate+visableVC.h"
//#import "HJTMainTabBarVC.h"
//#import "KMSlideWindow.h"
@implementation AppDelegate (visableVC)

+ (UIViewController *)getVisableVC
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return [delegate getVisableVC];
}

+ (void)getNavVCWithBlock:(NavBlock)closure
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate getNavVCWithBlock:closure];
}

+ (UIView *)getVisableView
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return [delegate getVisableView];
}

- (UIViewController *)getVisableVC
{
    UIViewController * vc = self.window.rootViewController;
    NSMutableArray * vcsClassName = nil;

    while ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *)vc).visibleViewController;
    }
    
//    while ([vc isKindOfClass:[HJTMainTabBarVC class]]) {
//        vcsClassName = ((HJTMainTabBarVC *)vc).vcsClassName;
//        vc = ((HJTMainTabBarVC *)vc).selectedViewController;
//    }
    
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    
    for (NSString * classname in vcsClassName) {
        if ([vc isKindOfClass:NSClassFromString(classname)]) {
            vc = vc.tabBarController ?: vc;
            break;
        }
    }
//    if ([vc.view.subviews.lastObject isKindOfClass:NSClassFromString(@"KMSlideWindow")]) {
//        KMSlideWindow *sw = vc.view.subviews.lastObject;
//        return sw.subVCs.lastObject;
//    }
    return vc;
}

- (UIView *)getVisableView
{
    UIViewController * vc = [self getVisableVC];
    return vc.view;
}

- (void)getNavVCWithBlock:(NavBlock)closure
{
    UIViewController * tmpVC = [self getVisableVC];
    //如果是tabbar 则需要选定的vc
    if ([tmpVC isKindOfClass:[UITabBarController class]]) {
        tmpVC = ((UITabBarController *)tmpVC).selectedViewController;
    }
    //如果选定的vc 是nav或者nav不为nil，则直接返回
    UINavigationController * navi = [tmpVC isKindOfClass:[UINavigationController class]] ? (UINavigationController*)tmpVC : tmpVC.navigationController;
    
    if (navi) {
        closure(navi);
    }
    else
    {
        //问题出现 如果tmpvc 不是nav 且没有nav
        //如果是被present出来的vc，则先dismiss再尝试寻找nav
        if (tmpVC.presentingViewController) {
            [tmpVC dismissViewControllerAnimated:YES completion:^{
                [self getNavVCWithBlock:closure];
            }];
        }
        else//如果不是，则nil，暂不处理
        {
            //考虑人为创建
            //            closure(nil);
        }

    }
}

+ (void)gotoHomeWithSelectedIndex:(NSUInteger)selectedIndex
{
    UIViewController * vc = [self getRootViewController];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        //root
        UINavigationController * rootNav = (UINavigationController *)vc;
        [self getNavVCWithBlock:^(UINavigationController *nav) {
            if ([rootNav isEqual:nav]) {
                if (rootNav.viewControllers.count > 1)
                {
                    [rootNav popToRootViewControllerAnimated:NO];
                }
                if([rootNav.viewControllers.firstObject isKindOfClass:[UITabBarController class]])
                {
                    UITabBarController * tabbar = (UITabBarController *)rootNav.viewControllers.firstObject;
                    if (selectedIndex < tabbar.viewControllers.count) {
                        tabbar.selectedIndex = selectedIndex;
                    }
                }
            }
            else
            {
                if (nav.presentingViewController) {
                    [nav dismissViewControllerAnimated:YES completion:^{
                        [self gotoHomeWithSelectedIndex:selectedIndex];
                    }];
                }
            }
        }];
        
        

    }
}

+ (UIViewController *)getRootViewController
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController * vc = delegate.window.rootViewController;
    return vc;
}

@end
