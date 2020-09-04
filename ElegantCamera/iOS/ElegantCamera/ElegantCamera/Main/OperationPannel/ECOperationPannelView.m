//
//  ECOperationPannelView.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/1.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECOperationPannelView.h"
#import "ECBaseCV.h"
#import "ECMediaTakenView.h"
#import "ECIconDescControl.h"
#import "LGButton.h"
#import "UIView+ECAdd.h"

@interface ECSettingCCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ECSettingCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    _textLabel = [UILabel new];
    [self.contentView addSubview:_textLabel];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    _textLabel.font = [UIFont systemFontOfSize:14.f];
    _textLabel.textColor = kRGB_33;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [_textLabel sizeToFit];
}

@end

static NSInteger const kDefaultIndex = 1;
static CGFloat const kBottomWrapperViewH = 110.f;
static CGFloat const kCollectionViewH = 55.f;
static NSInteger const kRowNumber = 4;
static CGFloat const kCtrlWidth = 65.f;
static CGFloat const kCtrlHSpace = 10.f;
static CGFloat const kCtrlTopMargin = 15.f;
static CGFloat const kCtrlDescCenterYMargin = 10.f;

@interface ECOperationPannelView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ECIconDescControl *editorPhotoCtrl; // 编辑
@property (nonatomic, strong) ECIconDescControl *beautyCtrl; // 美白
@property (nonatomic, strong) ECIconDescControl *filterCtrl; // 滤镜
@property (nonatomic, strong) ECIconDescControl *stickerCtrl; // 贴纸
//修图、美颜、滤镜、贴纸；

//save photo
@property (nonatomic, strong) LGButton *saveBtn;
@property (nonatomic, strong) LGButton *editorBtn;
@property (nonatomic, strong) LGButton *albumBtn;

// has taken photo
@property (nonatomic, strong) ECIconDescControl *backCtrl; // 返回
@property (nonatomic, strong) ECIconDescControl *shareCtrl; // 分享

@property (nonatomic, strong) ECMediaTakenView *takenView;
@property (nonatomic, strong) NSMutableDictionary *takenViewDict;

@property (nonatomic, strong) ECBaseCV *collectionView;

@property (nonatomic, assign) NSInteger curIndex;

@property (nonatomic, strong) NSArray<NSString *> *datasource;

@end

@implementation ECOperationPannelView

- (void)baseInit {
    [super baseInit];
    
    self.backgroundColor = [UIColor grayColor];
    
    _takenViewDict = [NSMutableDictionary new];
    _curIndex = kDefaultIndex;
    _datasource = @[@"热门模块" ,@"拍摄" ,@"视频" ,@"表情包"];
    
    {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumInteritemSpacing = KMWidth(8.f);
//        CGFloat width = ceil([@"热门模块" sizeForFont:[UIFont systemFontOfSize:14.f] size:CGSizeMake(CGFLOAT_MAX, KMWidth(kCollectionViewH)) mode:NSLineBreakByTruncatingTail].width);
        CGFloat width = KMWidth(200.f);
        _collectionView = [[ECBaseCV alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        flowLayout.itemSize = CGSizeMake(width, KMWidth(kCollectionViewH));
        kCV_registerWithClassCell(_collectionView, ECSettingCCell);
        _collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:_collectionView];
        CGFloat totalWidth = width *self.datasource.count + (self.datasource.count-1) *KMWidth(8.f);
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(totalWidth);
            make.bottom.equalTo(self).offset(-(XN_BOTTOM_FIX +KMWidth(kBottomWrapperViewH)));
            make.height.mas_equalTo(KMWidth(kCollectionViewH));
        }];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.hidden = YES;
    }
    
    {
        _editorPhotoCtrl = [ECIconDescControl new];
        _filterCtrl = [ECIconDescControl new];
        _beautyCtrl = [ECIconDescControl new];
        _stickerCtrl = [ECIconDescControl new];
        _backCtrl = [ECIconDescControl new];
        _shareCtrl = [ECIconDescControl new];
        [self addSubviews:@[_editorPhotoCtrl, _filterCtrl, _beautyCtrl, _stickerCtrl, _backCtrl, _shareCtrl]];
        [_filterCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(-KMWidth(kCtrlWidth +kCtrlHSpace));
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        [_filterCtrl configIconName:@"icon_filter30" desc:@"滤镜"];
        [_filterCtrl.descL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.filterCtrl.mas_centerY).offset(KMWidth(kCtrlDescCenterYMargin));
        }];
        _filterCtrl.coverBtn.tag = ECMainPhotoTypeFilter;
        
        [_editorPhotoCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).multipliedBy(1.f/2.f);
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        [_editorPhotoCtrl configIconName:@"icon_editor_photo30" desc:@"修图"];
        [_editorPhotoCtrl.descL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.editorPhotoCtrl.mas_centerY).offset(KMWidth(kCtrlDescCenterYMargin));
        }];
        _editorPhotoCtrl.coverBtn.tag = ECMainPhotoTypeEditorPhoto;
        
        //         back
        [_backCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_filterCtrl).offset(-KMWidth(kCtrlWidth +kCtrlHSpace));
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        _backCtrl.coverBtn.tag = ECMainPhotoTypeBack;
        
        [_beautyCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(KMWidth(kCtrlWidth +kCtrlHSpace));
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        [_beautyCtrl configIconName:@"icon_beauty30" desc:@"美颜"];
        [_beautyCtrl.descL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.beautyCtrl.mas_centerY).offset(KMWidth(kCtrlDescCenterYMargin));
        }];
        _beautyCtrl.coverBtn.tag = ECMainPhotoTypeBeauty;
        
        [_stickerCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.beautyCtrl).offset(KMWidth(kCtrlWidth +kCtrlHSpace));
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        
        [_stickerCtrl configIconName:@"icon_sticker30" desc:@"贴纸"];
        [_stickerCtrl.descL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stickerCtrl.mas_centerY).offset(KMWidth(kCtrlDescCenterYMargin));
        }];
        _stickerCtrl.coverBtn.tag = ECMainPhotoTypeSticker;
        
        [_shareCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.beautyCtrl).offset(KMWidth(kCtrlWidth +kCtrlHSpace));
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        _shareCtrl.coverBtn.tag = ECMainPhotoTypeShare;
        
        {
            [_editorPhotoCtrl.coverBtn addTarget:self action:@selector(onCtrlAction:) forControlEvents:UIControlEventTouchUpInside];
            [_filterCtrl.coverBtn addTarget:self action:@selector(onCtrlAction:) forControlEvents:UIControlEventTouchUpInside];
            [_beautyCtrl.coverBtn addTarget:self action:@selector(onCtrlAction:) forControlEvents:UIControlEventTouchUpInside];
            [_stickerCtrl.coverBtn addTarget:self action:@selector(onCtrlAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [_backCtrl.coverBtn addTarget:self action:@selector(onCtrlAction:) forControlEvents:UIControlEventTouchUpInside];
            [_shareCtrl.coverBtn addTarget:self action:@selector(onCtrlAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    

//     editor photo
    {
        LGButton *editorBtn = [LGButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:editorBtn];
        _editorBtn = editorBtn;
        [editorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).multipliedBy(1.f/4.f);
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        [editorBtn setImage:[UIImage imageNamed:@"icon_editor_photo30"] forState:UIControlStateNormal];
        editorBtn.tag = ECMainPhotoTypeEditorPhoto;
        editorBtn.hidden = YES;
    }
    
//     save btn
    {
        LGButton *saveBtn = [LGButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:saveBtn];
        _saveBtn = saveBtn;
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).multipliedBy(3.f/2.f);
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        [saveBtn setImage:[UIImage imageNamed:@"icon_save30"] forState:UIControlStateNormal];
//        [saveBtn addTarget:self action:@selector(onCtrlAction:) forControlEvents:UIControlEventTouchUpInside];
        saveBtn.tag = ECMainPhotoTypeSavePhoto;
        saveBtn.hidden = YES;
    }
    
    {
        LGButton *albumBtn = [LGButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:albumBtn];
        _albumBtn = albumBtn;
        [albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.editorBtn.mas_right).offset(KMWidth(5.f));
            make.width.height.mas_equalTo(KMWidth(kCtrlWidth));
            make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(kCtrlTopMargin));
        }];
        [albumBtn setImage:[UIImage imageNamed:@"icon_album30"] forState:UIControlStateNormal];
    }
    
    
//    [self configViewWithTakenFlag:NO];
    
//FIXME: next time to fix me
    self.filterCtrl.hidden = YES;
    self.beautyCtrl.hidden = YES;
    self.stickerCtrl.hidden = YES;
    self.editorPhotoCtrl.hidden = YES;
    self.backCtrl.hidden = YES;
    self.shareCtrl.hidden = YES;
    
}

- (void)configViewWithTakenFlag:(BOOL)hasTaken {
    //    _editorPhotoCtrl.hidden = hasTaken;
    _filterCtrl.hidden = hasTaken;
    _beautyCtrl.hidden = hasTaken;
    _stickerCtrl.hidden = hasTaken;
    
    _backCtrl.hidden = !hasTaken;
    _shareCtrl.hidden = !hasTaken;
}

- (void)onCtrlAction:(UIButton *)sender {
    if ([self.pannelDelegate respondsToSelector:@selector(obj:actionWithParams:)]) {
        [self.pannelDelegate obj:self actionWithParams:@(sender.tag)];
    }
}

- (void)changeToCurIndex {
    [self changeToCategoryIndex:_curIndex];
}

- (void)changeToCategoryIndex:(NSInteger)index {
    ECMediaTakenView *mediaTakenView = [self configCurTakenViewWithIndex:index];
    if (mediaTakenView == _takenView && mediaTakenView != nil) {
        return;
    }
    
    [_takenView removeFromSuperview];
    _takenView = mediaTakenView;
    [self addSubview:_takenView];
    [self configTakenDelegateWithView:_takenView];
    
    [_takenView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.collectionView.mas_bottom).offset(KMWidth(8.f));
    }];
}

- (ECMediaTakenView *)configCurTakenViewWithIndex:(NSInteger)index {
    if (index >= kRowNumber || index <0) {
        return nil;
    }
    
    ECMediaTakenView *view = [_takenViewDict objectForKey:@(index)];
    if (!view) {
        view = [ECMediaTakenView createWithType:index];
    }
    
    return view;
}

- (void)configTakenDelegateWithView:(UIView *)curView {
    if (!curView ||  [curView isKindOfClass:[UIWindow class]]) {
        return;
    }
    
    UIViewController *vc = [UIApplication sharedApplication].windows.lastObject.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        vc = nav.viewControllers.firstObject;
    }
    if ([vc isKindOfClass:NSClassFromString(@"ECMainViewController")]) {
        self.takenView.mediaTakenViewDelegate =(id)vc;
    }
}

#pragma mark -- collection view datsource & delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ECSettingCCell *cell = kCV_reuseCellClass(collectionView, ECSettingCCell, indexPath);
    cell.textLabel.text = [self.datasource objectAtIndex:indexPath.item];
    [cell.textLabel sizeToFit];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了这个漫画");
}

@end
