//
//  XQAESUtil.h
//  EncryptDemo
//
//  Created by Oila on 2020/12/21.
//  Copyright © 2020 Oila. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XQAESUtil : NSObject

//  AES256 ECB
+ (NSString *)aes256ECBEncryptWithText:(NSString *)str key:(NSString *)key;

+ (NSString *)aes256ECBDecryptWithText:(NSString *)str key:(NSString *)key;

//AES256 CBC
+ (NSString *)aes256CBCEncryptWithText:(NSString *)str key:(NSString *)key iv:(NSString *)iv;

+ (NSString *)aes256CBCDecryptWithText:(NSString *)str key:(NSString *)key iv:(NSString *)iv;

//  AES128
+ (NSString *)aes128ECBEncryptWithText:(NSString *)str key:(NSString *)key;

+ (NSString *)aes128ECBDecryptWithText:(NSString *)str key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
