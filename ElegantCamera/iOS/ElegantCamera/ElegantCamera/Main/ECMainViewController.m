//
//  ViewController.m
//  ElegantCamera
//
//  Created by Aka on 2019/10/31.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECMainViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "ECMainView.h"
#import "ECMediaTakenView.h"
#import "ECCameraPreviewView.h"
#import "ECCameraSettingsView.h"
#import "ECOperationPannelView.h"
#import "ECCameraSettingsMoreView.h"
#import "ECSettingsViewController.h"

#import "ECTakenManger.h"

#import "DDLog+LOGV.h"

@interface ECMainViewController ()<ECMediaTakenViewProtocol>

@property (nonatomic, strong) ECMainView *view;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *curPreviewLayer;

@end

@implementation ECMainViewController

EC_DYNAMIC_VIEW(ECMainView);

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    NSLog(@"lt - hre ;");
    
}

- (void)initPre {
    
    [[ECTakenManger single] requestAuthorization:^(BOOL flag) {
        dispatch_async_on_main_queue(^{
            if (!flag) {
                 return ;
             }
            [self configViewAndVariables];
        });
    }];
}

- (void)initView {
    
}

- (void)initBind {
    self.view.operationPannelView.pannelDelegate = self;
    
}

- (void)initText {
    
}

- (void)configViewAndVariables {
    [[ECTakenManger single] configBaseVariables];
    self.curPreviewLayer = [ECTakenManger single].previewLayer;
    [self.view.cameraPreviewView.layer addSublayer:self.curPreviewLayer];
    self.curPreviewLayer.frame = CGRectMake(0.f, 0.f, self.view.cameraPreviewWidth, self.view.cameraPreviewHeight);
}

#pragma mark -- ECMediaTakenViewProtocol

- (void)mediaView:(ECMediaTakenView *)view actionType:(ECMediaTakenType)type recognizer:(nonnull UIGestureRecognizer *)gr {
    if (ECMediaTakenTypeTakeShot ==  type) {
        if ([gr isKindOfClass:[UITapGestureRecognizer class]]) {
            [self takePhoto];
        }
        else if ([gr isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [self takeShotVideo];
        }
        else {}
        
    }
    else {}
}

- (void)obj:(id)obj actionWithParams:(id)params {
    if ([obj isKindOfClass:[ECCameraSettingsView class]]) {
        if ([params isKindOfClass:[NSNumber class]]) {
            NSNumber *value =(NSNumber *)params;
            ECCameraSettingsType type = value.integerValue;
            if (type == ECCameraSettingsTypeMore) {
                [self showMoreSettings];
            }
            else if (type == ECCameraSettingsTypePreviewArea) {
                [self showCameraPreviewSettings];
            }
            else if (type == ECCameraSettingsTypeToggleCamera) {
                [[ECTakenManger single] toggleCemera];
            }
            else {}
        }
    }
    else if ([obj isKindOfClass:[ECCameraSettingsMoreView class]]) {
        [self onMoreAction:params];
    }
    else if ([obj isKindOfClass:[ECOperationPannelView class]]) {
        if ([params isKindOfClass:[NSNumber class]]) {
            [self onChangeMainCategory:((NSNumber *)params).integerValue];
        }
    }
    else {
    }
}

#pragma mark -- action

- (void)takePhoto {
    [[ECTakenManger single] takePhoto:^(UIImage *img, NSError *error) {
        NSLog(@"lt- take photo :%@",error);
    }];
}

- (void)takeShotVideo {
    
}

- (void)onChangeMainCategory:(NSInteger)categoryIndex {
    if (categoryIndex == ECMainPhotoTypeEditorPhoto) {
        [self onGetEditorImageThen:^(UIImage *img) {
           if (img) {
               NSLog(@"lt- img ");
           }
       }];
    }
    else if (categoryIndex == ECMainPhotoTypeBeauty) {
       
    }
    else if (categoryIndex == ECMainPhotoTypeSticker) {
        
    }
    else if (categoryIndex == ECMainPhotoTypeFilter) {
        
    }
}

@end

#import "ECPreviewRatioView.h"

@implementation ECMainViewController (CameraSettings)

- (void)showCameraPreviewSettings {
    dispatch_async_on_main_queue(^{
        ECPreviewRatioView *popView = [ECPreviewRatioView new];
        [popView showInView:self.view isShow:YES];  
    });
}


@end


@implementation ECMainViewController (MoreSettings)

- (void)showMoreSettings {
    dispatch_async_on_main_queue(^{
        ECCameraSettingsMoreView *popView = [ECCameraSettingsMoreView new];
        popView.actionProtocol = self;
        [popView showInView:self.view isShow:YES];
    });
}

- (void)onMoreAction:(id)params {
    if ([params isKindOfClass:[NSNumber class]]) {
        ECCameraSettingsMoreType moreType = [((NSNumber *)params) integerValue];
        if (moreType == ECCameraSettingsMoreTypeSettings) {
            [self.navigationController pushViewController:[ECSettingsViewController new] animated:YES];
        }
    }
}

@end

@implementation ECMainViewController (EditorPhoto) 

- (void)onGetEditorImageThen:(ImgBlock)then {
//     这个编辑好像有问题
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];

    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {

    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    NSLog(@"lt - :%d",isSelectOriginalPhoto);
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset {
    
}

// Decide album show or not't
// 决定相册显示与否 albumName:相册名字 result:相册原始数据
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    return YES;
}

// Decide asset show or not't
// 决定照片显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    return YES;
}

@end

@implementation ECMainViewController (Filter)

@end

@implementation ECMainViewController (Beauty)

@end

@implementation ECMainViewController (Sticker)

@end


@implementation ECMainViewController (WBGImageEditor)

- (void)onEditorWithImg:(UIImage *)originImg then:(ImgBlock)then {
    
}



@end


