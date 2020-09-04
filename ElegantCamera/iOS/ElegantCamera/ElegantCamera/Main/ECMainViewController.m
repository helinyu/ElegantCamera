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
#import <WSProgressHUD/WSProgressHUD.h>
#import "ECTakenManger.h"
#import "LGButton.h"
#import "DDLog+LOGV.h"
#import "CLImageEditor.h"

@interface ECMainViewController ()<ECMediaTakenViewProtocol, CLImageEditorDelegate>

@property (nonatomic, strong) ECMainView *view;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *curPreviewLayer;
@property (nonatomic, strong) UIImageView *previewImgView;

@property (nonatomic, strong) UIImage *takenImg;

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
    
    [self.view.closeBtn addTarget:self action:@selector(onCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.operationPannelView.saveBtn addTarget:self action:@selector(onSaveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.operationPannelView.editorBtn addTarget:self action:@selector(onEditorAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initText {
    
}

- (void)onCloseAction:(id)sender {
    [[ECTakenManger single] restartSession];
    self.view.closeBtn.hidden = YES;
}

- (void)onSaveAction:(id)sender {
    if (!self.takenImg) {
        NSLog(@"lt - 没有图片可以保存");
        return;
    }
    [[TZImageManager manager] savePhotoWithImage:self.takenImg completion:^(PHAsset *asset, NSError *error) {
        if (error) {
            NSLog(@"lt - 保存失败");
            return;
        }
        [self rescoverPreTakenENV];
        NSLog(@"lt - 保存成功");
    }];
}

- (void)onEditorAction:(id)sender {
//    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
//    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//
//    }];
//    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:self.takenImg];
    editor.delegate = self;
    
    [self presentViewController:editor animated:YES completion:nil];
}

- (void)rescoverPreTakenENV {
    self.view.closeBtn.hidden = YES;
    self.view.operationPannelView.saveBtn.hidden = YES;
    self.view.operationPannelView.editorBtn.hidden = YES;
    [self.view.cameraPreviewView sendSubviewToBack:self.previewImgView];
    [[ECTakenManger single] restartSession];
}

- (void)configViewAndVariables {
    [[ECTakenManger single] configBaseVariables];
    self.curPreviewLayer = [ECTakenManger single].previewLayer;
    [self.view.cameraPreviewView.layer addSublayer:self.curPreviewLayer];
    self.curPreviewLayer.frame = CGRectMake(0.f, 0.f, self.view.cameraPreviewWidth, self.view.cameraPreviewHeight);
    
    self.previewImgView = [UIImageView new];
    [self.view.cameraPreviewView addSubview:self.previewImgView];
    [self.previewImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.cameraPreviewView);
    }];
    self.previewImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view.cameraPreviewView sendSubviewToBack:self.previewImgView];
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
        if (error != nil) {
//            [WSProgressHUD showWithStatus:@"拍照失败" maskType:WSProgressHUDMaskTypeClear maskWithout:WSProgressHUDMaskWithoutDefault];
            return;
        }
        
        self.takenImg = img;
        self.previewImgView.image = img;
        [self.view.cameraPreviewView bringSubviewToFront:self.previewImgView];
        self.view.operationPannelView.saveBtn.hidden = NO;
        self.view.operationPannelView.editorBtn.hidden = NO;
        self.view.closeBtn.hidden = NO;
        [self.view bringSubviewToFront:self.view.closeBtn];
    }];
}

- (void)takeShotVideo {
    
}

- (void)onChangeMainCategory:(NSInteger)categoryIndex {
    if (categoryIndex == ECMainPhotoTypeEditorPhoto) {
        W_S;
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


- (void)showPreImgView {
    self.previewImgView.image = self.takenImg;
    [self.view.cameraPreviewView bringSubviewToFront:self.previewImgView];
}

#pragma mark -- CLImageEditorDelegate

- (void)imageEditor:(CLImageEditor*)editor didFinishEditingWithImage:(UIImage*)image {
    NSLog(@"lt - image :%@",image);
    
    if (!image) return;
    
    self.takenImg = image;
    [editor dismissViewControllerAnimated:YES completion:nil];
    [self showPreImgView];
}

- (void)imageEditorDidCancel:(CLImageEditor*)editor {
    NSLog(@"cancel editor; %@",editor);
    [editor dismissViewControllerAnimated:YES completion:nil];
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


