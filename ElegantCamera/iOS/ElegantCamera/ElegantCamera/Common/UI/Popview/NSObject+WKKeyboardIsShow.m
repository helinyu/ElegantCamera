//
//  NSObject+WKKeyboardIsShow.m
//  MKWeekly
//
//  Created by wangkun on 2017/8/11.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import "NSObject+WKKeyboardIsShow.h"

@implementation NSObject (WKKeyboardIsShow)

- (void)registerKeyboardShowNotificationWithShowSelector:(SEL)showCallback
                                            hideSelector:(SEL)hideCallBack
//                           textFVDidBeginEditingSelector:(SEL)fvDidBeginEditing textFVDidEndEditingSelector:(SEL)fvDidEndEditing
{
    //监听当键盘将要出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:showCallback
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:hideCallBack
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:fvDidBeginEditing name:UITextFieldTextDidBeginEditingNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:fvDidEndEditing name:UITextFieldTextDidEndEditingNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:fvDidBeginEditing name:UITextViewTextDidBeginEditingNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:fvDidEndEditing name:UITextViewTextDidEndEditingNotification object:nil];
    
}

- (void)unregisterKeyboardShowNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];


}

@end
