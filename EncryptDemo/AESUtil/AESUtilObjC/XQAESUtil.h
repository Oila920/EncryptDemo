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

//  AES256
+ (NSString *)aes25EncryptWithText:(NSString *)str key:(NSString *)key;

+ (NSString *)aes256DecryptWithText:(NSString *)str key:(NSString *)key;

//  AES128
+ (NSString *)aes128EncryptWithText:(NSString *)str key:(NSString *)key;

+ (NSString *)aes128DecryptWithText:(NSString *)str key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
