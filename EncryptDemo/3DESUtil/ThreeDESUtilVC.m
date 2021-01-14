//
//  ThreeDESUtilVC.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/22.
//  Copyright © 2020 Oila. All rights reserved.
//Pass

#import "ThreeDESUtilVC.h"
#import "XQ3DESUtil.h"

@interface ThreeDESUtilVC ()

@end

@implementation ThreeDESUtilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    因为DES秘钥为8字节，64位，因为其中一位没有用到，实质是56位，所以3DES秘钥为56*3=168位，最少52*2=112位，书写时写24字节，写21字节也是足够安全的
    NSString *key = @"123456781234567812345678";
    NSString *pwd = @"qwer";
    
//    ECB模式
    NSString *encryptStr = [XQ3DESUtil encrypt3DES:pwd key:key];
    NSString *decryptStr = [XQ3DESUtil decrypt3DES:encryptStr key:key];
    
    NSLog(@"\n\n3DES加密后的字符串：%@\n3DES解密后的字符串：%@\n\n",encryptStr,decryptStr);

    
    // Do any additional setup after loading the view from its nib.
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
