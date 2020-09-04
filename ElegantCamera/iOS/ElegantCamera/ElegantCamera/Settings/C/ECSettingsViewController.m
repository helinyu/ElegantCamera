//
//  ECSettingsViewController.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/11.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECSettingsViewController.h"
#import "ECSettingsTextTCell.h"
#import "ECSettingsSwitchTCell.h"
#import "ECSettingsRightArrowTCell.h"
#import "ECSettingsCircleSelectTCell.h"
#import "NSMutableArray+ECAdd.h"

#import "ECWaterMarkViewController.h"
#import "ECFeedbackViewController.h"
#import "ECPrivacyPolicyViewController.h"
#import "ECWebViewViewController.h"

@interface ECSettingsViewController ()<UITableViewDataSource, UITableViewDelegate, ECActionProtocol>

@property (nonatomic, strong) ECBaseTV *tableView;


@property (nonatomic, strong) NSArray<NSArray<ECSettingsModel *> *> *datasource;
@property (nonatomic, strong) NSArray<NSString *> *sectionTitles;
 
@end

@implementation ECSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"设置";
    
    _tableView = [[ECBaseTV alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NAVIGATION_STATUS_HEIGHT);
    }];
    NSArray<NSString *> *cellNames = @[@"ECSettingsTextTCell", @"ECSettingsRightArrowTCell", @"ECSettingsCircleSelectTCell", @"ECSettingsSwitchTCell"];
    kTV_registerCells(_tableView, cellNames);
    _tableView.rowHeight = KMWidth(70.f);
    _tableView.sectionHeaderHeight = KMWidth(30.f);
    _tableView.sectionFooterHeight = CGFLOAT_MIN;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    if (@available(iOS 11.0, *)) {
       self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
       self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self createDataSource];
}

- (void)createDataSource {
    ECSettingsModel *highQualityItem = [ECSettingsModel createWithName:@"高清画质" desc:@"选择高清画质，部分设备在拍摄时会有快门声" sectionType:ECSettingsSectionTypePhotoQuality contentType:ECSettingsContentTypeHighQuality content:@(NO)];
    ECSettingsModel *smoothItem = [ECSettingsModel createWithName:@"流畅拍摄" desc:@"流畅拍摄，部分机型的画质会降低" sectionType:ECSettingsSectionTypePhotoQuality contentType:ECSettingsContentTypeSmoothQuality content:@(NO)];
    
    ECSettingsModel *genderItem = [ECSettingsModel createWithName:@"男女识别" desc:@"开启后，将基于性别判断优化美妆效果" sectionType:ECSettingsSectionTypePhotoTaken contentType:ECSettingsContentTypeGenderIdentification content:@(NO)];
    ECSettingsModel *dispelSpotsItem = [ECSettingsModel createWithName:@"祛斑祛痘" desc:@"" sectionType:ECSettingsSectionTypePhotoTaken contentType:ECSettingsContentTypeDispelSpotsAndAcne content:@(NO)];
    ECSettingsModel *photoImgItem = [ECSettingsModel createWithName:@"照片镜像模式" desc:@"" sectionType:ECSettingsSectionTypePhotoTaken contentType:ECSettingsContentTypePhotoImageMode content:@(NO)];
    ECSettingsModel *waterMarkItem = [ECSettingsModel createWithName:@"水印设置" desc:@"" sectionType:ECSettingsSectionTypePhotoTaken contentType:ECSettingsContentTypeWaterMark content:@(NO)];
    
    ECSettingsModel *feedbackItem = [ECSettingsModel createWithName:@"意见反馈" desc:@"" sectionType:ECSettingsSectionTypeService contentType:ECSettingsContentTypeFeedback content:@(NO)];
    ECSettingsModel *userExperienceItem = [ECSettingsModel createWithName:@"加入用户体验改进计划" desc:@"" sectionType:ECSettingsSectionTypeService contentType:ECSettingsContentTypeJoinUserExperience content:@(NO)];
    ECSettingsModel *privacyPolicyItem = [ECSettingsModel createWithName:@"隐私政策" desc:@"" sectionType:ECSettingsSectionTypeService contentType:ECSettingsContentTypePrivacyPolicy content:@(NO)];
    ECSettingsModel *userAgreementItem = [ECSettingsModel createWithName:@"用户协议" desc:@"" sectionType:ECSettingsSectionTypeService contentType:ECSettingsContentTypeUserAgreement content:@(NO)];
    ECSettingsModel *appVersionItem = [ECSettingsModel createWithName:@"版本号" desc:kAppVersion sectionType:ECSettingsSectionTypeService contentType:ECSettingsContentTypeAppVersion content:@(0)];
    ECSettingsModel *cacheCleanItem = [ECSettingsModel createWithName:@"清理缓存" desc:@"" sectionType:ECSettingsSectionTypeService contentType:ECSettingsContentTypeCacheClean content:@(NO)];

    self.datasource = @[
        @[highQualityItem, smoothItem],
        @[genderItem, dispelSpotsItem, photoImgItem, waterMarkItem],
        @[feedbackItem, userExperienceItem, privacyPolicyItem, userAgreementItem, appVersionItem, cacheCleanItem]
    ];
    
    self.sectionTitles = @[@"画质选择", @"拍照设置", @"服务设置"];
   
}

#pragma mark -- tableView datasource & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datasource objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<ECSettingsModel *> *sectionDatas = [self.datasource safeObjectForIndex:indexPath.section];
    ECSettingsModel *item = [sectionDatas safeObjectForIndex:indexPath.row];
    if (indexPath.section == ECSettingsSectionTypePhotoQuality) {
        ECSettingsCircleSelectTCell *cell = kTV_ReuseCellDefaultName(tableView, ECSettingsCircleSelectTCell);
        cell.item = item;
        cell.actionDelegate = self;
        return cell;
    }
    else if ((indexPath.section == ECSettingsSectionTypePhotoTaken) || (indexPath.section == ECSettingsSectionTypeService && item.contentType == ECSettingsContentTypeJoinUserExperience)) {
      
        ECSettingsSwitchTCell *cell = kTV_ReuseCellDefaultName(tableView, ECSettingsSwitchTCell);
        cell.actionDelegate = self;
        cell.item = item;
        return cell;
    }
    else if (((indexPath.section == ECSettingsSectionTypeService) && (item.contentType == ECSettingsContentTypeFeedback || item.contentType == ECSettingsContentTypePrivacyPolicy || item.contentType == ECSettingsContentTypeUserAgreement))) {
        ECSettingsRightArrowTCell *cell = kTV_ReuseCellDefaultName(tableView, ECSettingsRightArrowTCell);
        cell.item = item;
        return cell;
        
    }
    else {
        ECSettingsTextTCell *cell = kTV_ReuseCellDefaultName(tableView, ECSettingsTextTCell);
        cell.item = item;
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sectionTitles safeObjectForIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ECSettingsBaseTCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray<ECSettingsModel *> *sectionDatas = [self.datasource safeObjectForIndex:indexPath.section];
     ECSettingsModel *item = [sectionDatas safeObjectForIndex:indexPath.row];
    
    if (ECSettingsSectionTypePhotoTaken == item.sectionType) {
        if (item.contentType == ECSettingsContentTypeWaterMark) {
            BOOL isOpen =((NSNumber *)item.content).boolValue;
            if (!isOpen) {
                return;
            }
            ECWaterMarkViewController *waterMarkVC = [ECWaterMarkViewController new];
            [self.navigationController pushViewController:waterMarkVC animated:YES];
        }
    }
    else if ([cell isKindOfClass:[ECSettingsRightArrowTCell class]]) {
      if (item.contentType == ECSettingsContentTypeFeedback) {
//            [self.navigationController pushViewController:[ECFeedbackViewController new] animated:YES];
//            反馈意见这个是不是经常要改？ 网页还是原生?
//             目前最好还是网页吧， 写一个网页android和iOS都进行使用
            
        }
        else if (item.contentType == ECSettingsContentTypePrivacyPolicy) {
            ECWebViewViewController *webVC = [ECWebViewViewController new];
                       webVC.urlString = @"https://m.samh.xndm.tech/samh_static/privacy/index.html";
           [self.navigationController pushViewController:webVC animated:YES];
        }
        else if (item.contentType == ECSettingsContentTypeUserAgreement) {
            ECWebViewViewController *webVC = [ECWebViewViewController new];
            webVC.urlString = @"https://m.samh.xndm.tech/samh_static/user_agreement/index.html";
            [self.navigationController pushViewController:webVC animated:YES];
        }
        else {}
    }
    else if ([cell isKindOfClass:[ECSettingsTextTCell class]]) {
       
        if (item.contentType == ECSettingsContentTypeCacheClean) {
            NSLog(@"lt- 清除缓存");
        }
    }
}


#pragma mark -- ECActionProtocol

- (void)obj:(id)obj actionWithParams:(id)params {
    if ([obj isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *curIndexPath = [self.tableView indexPathForCell:obj];
        NSArray<ECSettingsModel *> *sectionDatas = [self.datasource safeObjectForIndex:curIndexPath.section];
        ECSettingsModel *item = [sectionDatas safeObjectForIndex:curIndexPath.row];
        BOOL value = [item.content boolValue];
        item.content = @(!value);
        [self.tableView reloadRowsAtIndexPaths:@[curIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
