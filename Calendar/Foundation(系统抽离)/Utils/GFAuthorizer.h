//
//  GFAuthorizer.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#ifndef GFAuthorizer_h
#define GFAuthorizer_h

/**
 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
extern BOOL gf_check_photolibrary_authorization();

/**
 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
extern BOOL gf_check_camera_authorization();

/**
 8.0以后打开系统设置页面
 */
extern void gf_open_sys_setting() NS_AVAILABLE_IOS(8_0);

#endif /* GFAuthorizer_h */
