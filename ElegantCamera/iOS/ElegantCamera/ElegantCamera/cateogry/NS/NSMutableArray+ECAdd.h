//
//  NSMutableArray+ECAdd.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/8.
//  Copyright © 2019 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (ECAdd)

- (void)addSafeObject:(NSObject *)obj;

@end


@interface NSArray (ECAdd)

- (id)safeObjectForIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
