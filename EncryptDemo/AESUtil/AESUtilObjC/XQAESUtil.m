//
//  XQAESUtil.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/21.
//  Copyright © 2020 Oila. All rights reserved.
//
/*
 CCCryptorStatus cryptStatus = CCCrypt(...) 函数说明
 
CCCryptorStatus cryptStatus = CCCrypt(
kCCEncrypt,//kCCEncrypt 代表加密 kCCDecrypt代表解密
kCCAlgorithmAES,//加密算法
kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding，iOS只有CBC和ECB模式，如果想使用ECB模式，可以这样编写  kCCOptionPKCS7Padding | kCCOptionECBMode
keyPtr,//密钥
kCCKeySizeAES256,//密钥长度256
initVector.bytes,//偏移字符串，CBC模式，有向量IV的时候有值，否则为nil
data.bytes,//编码内容
dataLength,//数据长度
encryptedBytes,//加密输出缓冲区
encryptSize,//加密输出缓冲区大小
&actualOutSize);//实际输出大小

*/
//    默认偏移量为空
#define AES_IV @""

#import "XQAESUtil.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>

@implementation XQAESUtil

+ (NSString *)aes256ECBEncryptWithText:(NSString *)str key:(NSString *)key
{
    if (!str) {
        return nil;
    }
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *sourceData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [sourceData length];
    size_t buffersize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(buffersize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          NULL,
                                          [sourceData bytes],
                                          dataLength,
                                          buffer,
                                          buffersize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [encryptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    } else {
        free(buffer);
        return nil;
    }
    
}
+ (NSString *)aes256ECBDecryptWithText:(NSString *)str key:(NSString *)key
{
    if (!str) {
        return nil;
    }
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [decodeData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          NULL,
                                          [decodeData bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return result;
    } else {
        free(buffer);
        return nil;
        
    }
}

+ (NSString *)aes128ECBEncryptWithText:(NSString *)str key:(NSString *)key
{
    NSData *encryptData = [str dataUsingEncoding:NSUTF8StringEncoding];
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [AES_IV getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [encryptData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          ivPtr,
                                          [encryptData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(buffer);
    return nil;
}
+ (NSString *)aes128ECBDecryptWithText:(NSString *)str key:(NSString *)key
{
    
    NSData *decryptData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    char keyPtr[kCCKeySizeAES128 + 1];
       bzero(keyPtr, sizeof(keyPtr));
       [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
       
       char ivPtr[kCCBlockSizeAES128 + 1];
       bzero(ivPtr, sizeof(ivPtr));
       [AES_IV getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
       
       NSUInteger dataLength = [decryptData length];
       size_t bufferSize = dataLength + kCCBlockSizeAES128;
       void *buffer = malloc(bufferSize);
       size_t numBytesDecrypted = 0;
       CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                             kCCOptionPKCS7Padding|kCCOptionECBMode,
                                             keyPtr, kCCBlockSizeAES128,
                                             ivPtr,
                                             [decryptData bytes], dataLength,
                                             buffer, bufferSize,
                                             &numBytesDecrypted);
       if (cryptStatus == kCCSuccess) {
           return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted] encoding:NSUTF8StringEncoding];
       }
       free(buffer);
       return nil;
    
}
+ (NSString *)aes256CBCEncryptWithText:(NSString *)str key:(NSString *)key iv:(NSString *)iv
{
    if (!str) {
        return nil;
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[self AES256CBCModelOperation:kCCEncrypt data:data key:key iv:iv] base64EncodedStringWithOptions:0]; ;
}
+ (NSString *)aes256CBCDecryptWithText:(NSString *)str key:(NSString *)key iv:(NSString *)iv
{
    if (!str) {
           return nil;
       }

    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSData *decryptData = [self AES256CBCModelOperation:kCCDecrypt data:decodeData key:key iv:iv];

    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}
 
/**
 * AES256CBC模式加解密算法
 *
 * @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 * @param data      待加密Data数据
 * @param key       key
 * @param iv        向量，根据数据块大小126为16字节的随机数，256块则为32字节的随机数
 *
 */
+ (NSData *)AES256CBCModelOperation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    NSUInteger dataLength = data.length;
    // 为结束符'\\0' +1
    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCKeySizeAES256;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    
    NSData *initVector = [iv dataUsingEncoding:NSUTF8StringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(
                                          operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          initVector.bytes,
                                          data.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize];
    }
    free(encryptedBytes);
    return nil;
}
 
@end
