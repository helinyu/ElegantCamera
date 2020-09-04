//
//  WKPopBaseView.m
//  MKWeekly
//
//  Created by wangkun on 2017/8/2.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import "WKPopBaseView.h"
#import "NSObject+WKKeyboardIsShow.h"
#import "UIView+YYAdd.h"
#import "NSObject+YYAdd.h"

@interface WKPopBaseView ()



@end

@implementation WKPopBaseView


#pragma mark 布局相关
- (void)setInterFace
{
    [super setInterFace];
    _contentView = [UIView new];
    [_contentView setBackgroundColor:kRGB_FF];
    [self addSubview:_contentView];
    [self registerKeyboardShowNotificationWithShowSelector:@selector(keyboardWillShow:) hideSelector:@selector(keyboardWillHidden:)];
    self.priority = WKBaseViewShowPriorityNormal;

}



-(void)showInView:(UIView *)view isShow:(BOOL)flag
{
    [super showInView:view isShow:flag];
//    [WSProgressHUD dismiss]; //解解pop冲突
}



#pragma mark 监听相关
- (void)keyboardWillShow:(NSNotification *)noti
{
    
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    [self keyboardStateIsShow:YES height:height];
}

- (void)keyboardWillHidden:(NSNotification *)noti
{
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    [self keyboardStateIsShow:NO height:height];
}

- (void)keyboardStateIsShow:(BOOL)isShow height:(CGFloat)height
{
    ///canFix 现在的键盘弹出的噶便改变是针对 contentview的底部进行整体移动  基本实现要求 但有特殊需要可参考iqkeyboardmanager 再添加4个通知实现
    UIView * keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect textFieldViewRect = [self convertRect:self.contentView.frame toView:keyWindow];
    CGFloat keyboradTop = SCREEN_HEIGHT - height;
    CGFloat viewBottom = CGRectGetMaxY(textFieldViewRect);
    if (isShow) {
        if ( viewBottom > keyboradTop) {
            [UIView animateWithDuration:0.25 animations:^{
                self.top -= viewBottom - keyboradTop;
            }];
        }
    }
    else
    {
        if (self.top < 0) {
            [UIView animateWithDuration:0.25 animations:^{
                self.top = 0;
            }];
        }
    }
}
#pragma mark object methods
-(void)dealloc
{
    [self unregisterKeyboardShowNotification];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
