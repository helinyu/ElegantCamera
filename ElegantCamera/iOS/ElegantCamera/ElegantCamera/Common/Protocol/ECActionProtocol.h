//
//  ECActionProtocol.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ECActionProtocol <NSObject>

@optional
- (void)obj:(id)obj actionWithParams:(__nullable id)params;

@end


NS_ASSUME_NONNULL_END
