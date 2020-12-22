//
//  NSString+SafeUrlBase64.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/22.
//  Copyright © 2020 Oila. All rights reserved.
//

#import "NSString+SafeUrlBase64.h"

@implementation NSString (SafeUrlBase64)


//用于编码上送报文
+(NSString *)safeUrlBase64Decode:(NSString *)safeUrlbase64Str
{
    //进行以下替换
    // '-' -> '+'
    // '_' -> '/'
    // 不足4倍长度，补'='
    NSMutableString * base64Str = [[NSMutableString alloc]initWithString:safeUrlbase64Str];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSInteger mod4 = base64Str.length % 4;
    if(mod4 > 0)
        [base64Str appendString:[@"====" substringToIndex:(4-mod4)]];
    return base64Str;
}
//  用于解密返回报文
+(NSString *)safeUrlBase64Encode:(NSString *)base64Str
{
    //进行以下替换
    // '+' -> '-'
    // '/' -> '_'
    // '=' -> ''
    NSMutableString * safeBase64Str = [[NSMutableString alloc]initWithString:base64Str];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return safeBase64Str;
}

@end
