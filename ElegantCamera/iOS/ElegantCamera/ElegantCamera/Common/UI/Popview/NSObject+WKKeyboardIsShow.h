//
//  NSObject+WKKeyboardIsShow.h
//  MKWeekly
//
//  Created by wangkun on 2017/8/11.
//  Copyright © 2017年 zymk. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (WKKeyboardIsShow)

//考虑模仿iqkeyboard 增加监听 但是实际应用层面不需要
- (void)registerKeyboardShowNotificationWithShowSelector:(SEL)showCallback
                                            hideSelector:(SEL)hideCallBack;
//                           textFVDidBeginEditingSelector:(SEL)fvDidBeginEditing
//                             textFVDidEndEditingSelector:(SEL)fvDidEndEditing;
- (void)unregisterKeyboardShowNotification;

@end
