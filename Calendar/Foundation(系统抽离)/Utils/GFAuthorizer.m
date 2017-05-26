//
//  GFAuthorizer.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "GFAuthorizer.h"

BOOL gf_check_photolibrary_authorization()
{
    if ([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)])
    {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (ALAuthorizationStatusDenied == authStatus ||
            ALAuthorizationStatusRestricted == authStatus)
            return NO;
    }
    return YES;
}

BOOL gf_check_camera_authorization()
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        return NO;
    
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus)
            return NO;
    }
    
    return YES;
}

void gf_open_sys_setting()
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)
    {
        UIApplication *app = [UIApplication sharedApplication];
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([app canOpenURL:settingsURL])
            [app openURL:settingsURL];
    }
}
