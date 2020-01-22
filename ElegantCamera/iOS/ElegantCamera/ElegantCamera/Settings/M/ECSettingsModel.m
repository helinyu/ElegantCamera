//
//  ECSettingsModel.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/13.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECSettingsModel.h"



@implementation ECSettingsModel

+ (instancetype)createWithName:(NSString *)name desc:(NSString *)desc sectionType:(ECSettingsSectionType)sectionType contentType:(ECSettingsContentType)contentType content:(NSNumber *)content {
    ECSettingsModel *item = [ECSettingsModel new];
    item.name = name;
    item.desc = desc;
    item.sectionType = sectionType;
    item.contentType = contentType;
    return item;
}

@end
