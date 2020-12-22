//
//  DESUtilVC.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/22.
//  Copyright © 2020 Oila. All rights reserved.
//Pass

#import "DESUtilVC.h"
#import "XQDESUtil.h"

@interface DESUtilVC ()

@end

@implementation DESUtilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *key = @"12345678";
    NSString *pwd = @"qwer";
    
    NSString *encryptStr = [XQDESUtil encryptDES:pwd key:key];
    NSString *decryptStr = [XQDESUtil decryptDES:encryptStr key:key];
    
    NSLog(@"\n\nDES加密后的字符串：%@\nDES解密后的字符串：%@\n\n",encryptStr,decryptStr);

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