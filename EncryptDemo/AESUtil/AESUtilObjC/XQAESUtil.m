//
//  XQAESUtil.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/21.
//  Copyright © 2020 Oila. All rights reserved.
//

//    默认偏移量为空
#define AES_IV @""

#import "XQAESUtil.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>

@implementation XQAESUtil

+ (NSString *)aes25EncryptWithText:(NSString *)str key:(NSString *)key
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
      CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [sourceData bytes], dataLength, buffer, buffersize, &numBytesEncrypted);
       
      if (cryptStatus == kCCSuccess) {
          NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
          return [encryptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
      } else {
          free(buffer);
          return nil;
      }

}
+ (NSString *)aes256DecryptWithText:(NSString *)str key:(NSString *)key
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
       CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [decodeData bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
       if (cryptStatus == kCCSuccess) {
           NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
           NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           return result;
       } else {
           free(buffer);
           return nil;

}
}

+ (NSString *)aes128EncryptWithText:(NSString *)str key:(NSString *)key
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
+ (NSString *)aes128DecryptWithText:(NSString *)str key:(NSString *)key
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

@end
