//
//  ECBaseViewController.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/1.
//  Copyright © 2019 Aka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define EC_DYNAMIC_VIEW(ECView) \
@dynamic view; \
\
- (void)loadView { \
    self.view = [[ECView alloc] initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]; \
}

@interface ECBaseViewController : UIViewController

- (void)initPre;
- (void)initView;
- (void)initBind;
- (void)initText;

@end

NS_ASSUME_NONNULL_END
