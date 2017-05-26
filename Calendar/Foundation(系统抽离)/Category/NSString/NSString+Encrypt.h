//
//  NSString+Encrypt.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

- (NSString *)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
- (NSString *)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
