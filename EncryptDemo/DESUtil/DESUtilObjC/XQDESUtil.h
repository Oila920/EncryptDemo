//
//  XQDESUtil.h
//  EncryptDemo
//
//  Created by Oila on 2020/12/22.
//  Copyright © 2020 Oila. All rights reserved.
//
/*
   EDS加解密
   加密模式：ECB模式
   填充：PKCS7Padding
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XQDESUtil : NSObject

+(NSString *) encryptDES:(NSString *)plainText key:(NSString *)key;

+(NSString *)decryptDES:(NSString *)cipherText key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
