//
//  XQ3DESUtil.h
//  EncryptDemo
//
//  Created by Oila on 2020/12/22.
//  Copyright © 2020 Oila. All rights reserved.
//

/*
    3EDS加解密
    加密模式：ECB模式
    填充：PKCS7Padding 
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XQ3DESUtil : NSObject

+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key;

+ (NSString *)decrypt3DES:(NSString *)src key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
