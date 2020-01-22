//
//  XNCommonBlock.h
//  xndm_proj
//
//  独学而无友 则孤陋寡闻
//
//  Created by helinyu on 2019/6/14 17:04 .
//  Copyright © 2019 Linfeng Song. All rights reserved.
//  xcode 10.15 .
//
    

#ifndef XNCommonBlock_h
#define XNCommonBlock_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//返回值_参数_类型
//ns block
typedef void(^BOOLBlock)(BOOL value);
typedef void(^CGFloatBlock)(CGFloat value);
typedef void(^IntergerBlock)(NSUInteger value);
typedef void(^VoidBlock)(void);
typedef void(^StringBlock)(NSString *value);
typedef void(^ArrBlock)(NSArray * res);

typedef void(^void_bool_id_string_closure)(BOOL suc,id content,NSString * info);

//ui block
typedef void(^ImgBlock)(UIImage * img);
typedef void(^ImgInfoBlock)(UIImage * img, NSError *error);
typedef void(^BtnBlock)(UIButton * btn);
typedef void(^NavBlock)(UINavigationController * nav);

#endif /* XNCommonBlock_h */
