//
//  NSMutableArray+ECAdd.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/8.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "NSMutableArray+ECAdd.h"

@implementation NSMutableArray (ECAdd)

- (void)addSafeObject:(NSObject *)obj {
    if (!obj) {
        return;
    }
    
    [self addObject:obj];
}

@end


@implementation NSArray (ECAdd)

- (id)safeObjectForIndex:(NSInteger)index {
  if (index <0 || index >= self.count) {
      return nil;
  }
  return [self objectAtIndex:index];
}

@end
