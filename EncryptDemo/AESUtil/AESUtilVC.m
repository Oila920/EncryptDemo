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
     秘钥为32字节，即hex64位，256位
     */
    NSString *key = @"12345678901234567890123456789012";
    
    NSString *pwd = @"qwer";
    
    NSString *encryptStr = [XQAESUtil aes25EncryptWithText:pwd key:key];
    NSString *decryptStr = [XQAESUtil aes256DecryptWithText:encryptStr key:key];
    
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
    
    NSString *encryptStr = [XQAESUtil aes128EncryptWithText:pwd key:key];
    NSString *decryptStr = [XQAESUtil aes128DecryptWithText:encryptStr key:key];
    
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
