//
//  NSString+SafeUrlBase64.h
//  EncryptDemo
//
//  Created by Oila on 2020/12/22.
//  Copyright © 2020 Oila. All rights reserved.
//

/*
    Base64编码中包含有+,/,=不安全的URL字符串，
    进行网络交互的时候，需要对以上字符进行替换操作。
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SafeUrlBase64)


//用于编码上送报文
+(NSString *)safeUrlBase64Decode:(NSString *)safeUrlbase64Str;
//  用于解密返回报文
+(NSString *)safeUrlBase64Encode:(NSString *)base64Str;
@end

NS_ASSUME_NONNULL_END
