//
//  ECSettingsModel.h
//  ElegantCamera
//
//  Created by Aka on 2019/11/13.
//  Copyright © 2019 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, ECSettingsSectionType) {
    ECSettingsSectionTypePhotoQuality =0,
    ECSettingsSectionTypePhotoTaken,
    ECSettingsSectionTypeService,
};

typedef NS_ENUM(NSUInteger, ECSettingsContentType) {
    ECSettingsContentTypeHighQuality,
    ECSettingsContentTypeSmoothQuality,
    
    ECSettingsContentTypeGenderIdentification,
    ECSettingsContentTypeDispelSpotsAndAcne,
    ECSettingsContentTypePhotoImageMode,
    ECSettingsContentTypeWaterMark,

    ECSettingsContentTypeFeedback,
    ECSettingsContentTypeJoinUserExperience,
    ECSettingsContentTypePrivacyPolicy,
    ECSettingsContentTypeUserAgreement,
    ECSettingsContentTypeAppVersion,
    ECSettingsContentTypeCacheClean,
};

NS_ASSUME_NONNULL_BEGIN

@interface ECSettingsModel: NSObject

@property (nonatomic, assign) ECSettingsSectionType sectionType;
@property (nonatomic, assign) ECSettingsContentType contentType;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic)  id content;

+ (instancetype)createWithName:(NSString *)name desc:(NSString *)desc sectionType:(ECSettingsSectionType)sectionType contentType:(ECSettingsContentType)contentType content:(NSNumber *)content;

@end

NS_ASSUME_NONNULL_END
