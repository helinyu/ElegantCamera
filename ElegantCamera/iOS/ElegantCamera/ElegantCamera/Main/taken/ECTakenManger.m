//
//  ECTakenManger.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/4.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECTakenManger.h"
#import <AVFoundation/AVFoundation.h>

@interface ECTakenManger ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureDeviceInput *audioInput;
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutput;

@end

@implementation ECTakenManger

+ (instancetype)single{
    static dispatch_once_t token;
    static ECTakenManger *manager;
    dispatch_once(&token, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (void)configBaseVariables {
    AVCaptureSession *captureSession = [AVCaptureSession new];
    self.captureSession = captureSession;
    [captureSession setSessionPreset:AVCaptureSessionPresetPhoto]; // 为什么设置预览的图片
 
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//FIXME: 下面的这些类型暂时先不管
//    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//    AVCaptureDevice *textDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeText];
//    AVCaptureDevice *closedCaptionDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeClosedCaption];
//    AVCaptureDevice *subTitleDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeSubtitle];
//    AVCaptureDevice *timecodeDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeTimecode];
//    AVCaptureDevice *metaDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeMetadata];
//    AVCaptureDevice *muxedDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeMuxed];

    NSError *inputError =nil;
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&inputError];
    if (inputError || !videoInput || ![_captureSession canAddInput:videoInput]) {
        return;
    }
    [_captureSession addInput:videoInput];
    _videoInput = videoInput;

    // 音频输入
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:&inputError];
    if (inputError || !audioInput || ![_captureSession canAddInput:audioInput]) {
       return;
    }
    [_captureSession addInput:audioInput];
    _audioInput = audioInput;

    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    previewLayer.frame = [UIScreen mainScreen].bounds;
    _previewLayer = previewLayer;
    
    [_captureSession startRunning];
}

- (void)toggleCemera {

    [self.captureSession beginConfiguration];
       
    AVCaptureDevicePosition currentPosition = self.videoInput.device.position;
    AVCaptureDevicePosition needChangePosition = currentPosition == AVCaptureDevicePositionFront ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    AVCaptureDevice *device =[self cameroWithPosition:needChangePosition];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [self.captureSession removeInput:self.videoInput];
    [self.captureSession addInput:deviceInput];
    self.videoInput = deviceInput;

    [self.captureSession commitConfiguration];
}

//获取可用的摄像头
- (AVCaptureDevice *)cameroWithPosition:(AVCaptureDevicePosition)position{
    if (@available(iOS 10.0, *)) {
       AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:position];
        return device;
    } else {
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *device in devices) {
           if ([device position] == position) {
               return device;
           }
        }
    }
    return nil;
}

- (void)restartSession {
    [self.captureSession startRunning];
}
- (void)stopSession {
    [self.captureSession stopRunning];
}

@end

@implementation ECTakenManger (authorization)

- (void)requestAuthorization:(BOOLBlock)then {
   AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        !then? :then(YES);
        return;
    }
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:then];
}

@end


@implementation ECTakenManger (Photo)


- (void)takePhoto:(ImgInfoBlock)then {
     AVCaptureStillImageOutput *imageOutput = [[AVCaptureStillImageOutput alloc] init];
     imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
     if ([_captureSession canAddOutput:imageOutput]) {
         [_captureSession addOutput:imageOutput];
         _imageOutput = imageOutput;
     }

     // 输出图片
     AVCaptureConnection *connection = [_imageOutput connectionWithMediaType:AVMediaTypeVideo];
     if (connection.isVideoOrientationSupported) {
         connection.videoOrientation = AVCaptureVideoOrientationPortrait;
     }
     id takePictureSuccess = ^(CMSampleBufferRef sampleBuffer,NSError *error){
         if (sampleBuffer == NULL) {
             !then? :then(nil, error);
             return ;
         }
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:sampleBuffer];
         UIImage *image = [[UIImage alloc]initWithData:imageData];
         [self stopSession];
         !then? :then(image, error);
     };
     [_imageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:takePictureSuccess];
//    [imageOutput prepareToCaptureStillImageBracketFromConnection:connection withSettingsArray:nil completionHandler:^(BOOL prepared, NSError * _Nullable error) {
//        NSLog(@"lt - prepare :%d , error :%@",prepared, error);
//    }];
//    [_captureSession stopRunning];
}

@end


@implementation ECTakenManger (Video)

- (void)takeShotVideo:(StringBlock)then {
    
}


@end

@implementation ECTakenManger (ShortVideo)

@end

@implementation ECTakenManger (LongVideo)

@end

