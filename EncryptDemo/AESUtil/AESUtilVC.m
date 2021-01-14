//
//  AESUtilVC.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/21.
//  Copyright © 2020 Oila. All rights reserved.
//Pass

#import "AESUtilVC.h"
#import "XQAESUtil.h"

@interface AESUtilVC ()

@end

@implementation AESUtilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AES128&AES256";
    [self AES128];
    
    [self AES256];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)AES256
{
    /*
     aes256
     秘钥为32字节，256位
     */
    NSString *key = @"12345678901234567890123456789012";
    
    NSString *pwd = @"qwerqwerqwer";
    
//  根据数据块大小而定，126为16字节的随机数，256块则为32字节的随机数，可以为16进制数，也可以为是十进制数，iOS数据块为128
    NSString *iv = @"123456789012EC56";
//    CBC模式
    NSString *encryptStr = [XQAESUtil aes256CBCEncryptWithText:pwd key:key iv:iv];
    NSString *decryptStr = [XQAESUtil aes256CBCDecryptWithText:encryptStr key:key iv:iv];
    
    NSLog(@"\n\nAES256加密后的字符串：%@\nAES256解密后的字符串：%@\n\n",encryptStr,decryptStr);
}
- (void)AES128
{
    /*
     aes128
     秘钥为16字节，即hex32位，128位
     */
    NSString *key = @"1234567890123456";
    NSString *pwd = @"qwer";
    
    NSString *encryptStr = [XQAESUtil aes128ECBEncryptWithText:pwd key:key];
    NSString *decryptStr = [XQAESUtil aes128ECBDecryptWithText:encryptStr key:key];
    
    NSLog(@"\n\nAES128加密后的字符串：%@\nAES128解密后的字符串：%@\n\n",encryptStr,decryptStr);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
