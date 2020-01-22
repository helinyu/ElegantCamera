//
//  ViewController.h
//  ElegantCamera
//
//  Created by Aka on 2019/10/31.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECBaseViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>


@interface ECMainViewController : ECBaseViewController

@end

@interface ECMainViewController (CameraSettings)

- (void)showCameraPreviewSettings;

@end


@interface ECMainViewController (MoreSettings)

- (void)showMoreSettings;

- (void)onMoreAction:(id)params;

@end

@interface ECMainViewController (EditorPhoto)<TZImagePickerControllerDelegate>

- (void)onGetEditorImageThen:(ImgBlock)then;

@end


@interface ECMainViewController (Filter)

@end

@interface ECMainViewController (Beauty)

@end

@interface ECMainViewController (Sticker)

@end


#import "WBGImageEditor.h"
#import "WBGMoreKeyboardItem.h"

@interface ECMainViewController (WBGImageEditor)<WBGImageEditorDelegate, WBGImageEditorDataSource, WBGImageEditorTransitionDelegate>

- (void)onEditorWithImg:(UIImage *)originImg then:(ImgBlock)then;


@end



