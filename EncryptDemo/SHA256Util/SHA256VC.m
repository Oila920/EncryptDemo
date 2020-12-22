//
//  SHA256VC.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/21.
//  Copyright © 2020 Oila. All rights reserved.
//Pass

#import "SHA256VC.h"
#import "XQSHA256Util.h"

@interface SHA256VC ()

@end

@implementation SHA256VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     sha256
     输出为hex格式64位，即32字节，256位
     */
    
    NSString *pwd = @"1234567890";
    
    NSString *str = [XQSHA256Util sha256HashFor:pwd];
    NSLog(@"\n\nsha256>>>>>>%@\n\n",str);
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

