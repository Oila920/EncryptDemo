//
//  ViewController.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/13.
//  Copyright © 2020 Oila. All rights reserved.
//
#define PUSH_VC(class) [self.navigationController pushViewController:[[class alloc]init] animated:YES]

#import "ViewController.h"
#import "GMEncryptVC.h"
#import "RSAEncryptVC.h"
#import "SHA256VC.h"
#import "AESUtilVC.h"
#import "DESUtilVC.h"
#import "ThreeDESUtilVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加密算法";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (IBAction)GMBtnClicked:(id)sender {
    PUSH_VC(GMEncryptVC);
}
- (IBAction)RSABtnClicked:(id)sender {
    PUSH_VC(GMEncryptVC);
}
- (IBAction)SHA256BtnClicked:(id)sender {
    PUSH_VC(SHA256VC);
}
- (IBAction)AES256BtnClicked:(id)sender {
    PUSH_VC(AESUtilVC);
}
- (IBAction)DESBtnClicked:(id)sender {
    PUSH_VC(DESUtilVC);
}
- (IBAction)ThreeDESBtnClicked:(id)sender {
    PUSH_VC(ThreeDESUtilVC);
}
@end
