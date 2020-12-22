//
//  GMEncryptVC.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/13.
//  Copyright © 2020 Oila. All rights reserved.
//Pass

#import "GMEncryptVC.h"
#import "GMObjC.h"

@interface GMEncryptVC ()

@end

@implementation GMEncryptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SM2];
    
    [self SM3];

    [self SM4];

    // Do any additional setup after loading the view from its nib.
}
- (void)SM2
{
//     1字节 = 2hex = 8bit
    
    /* 公钥长度：是SM2曲线上的一个点，用横坐标和纵坐标两个分量来表示，记为（x，y），简记为Q，一个分量的长度是256位；
     SM2非压缩公钥格式字节串长度为65字节，压缩格式长度为33字节，若公钥y坐标最后一位为0，则首字节为0x02，否则为0x03。非压缩格式公钥首字节为0x04。
     公钥为Bit string类型，内容为04||X||Y，其中X和Y分别标识公钥的X分量和Y分量。其长度各为256位。
     */
    // 公钥 除了开头的04：64字节 hex128 512位 hex格式
    NSString *gPubkey = @"0408E3FFF9505BCFAF9307E665E9229F4E1B3936437A870407EA3D97886BAFBC9C624537215DE9507BC0E2DD276CF74695C99DF42424F28E9004CDE4678F63D698";
   
    //    私钥是一个大于1且小于n-1的整数（n为SM2算法的阶），私钥为intger类型 hex格式
    // 私钥 32字节 64hex 256位
    NSString *gPrikey = @"90F3A42B9FE24AB196305FD92EC82E647616C3A3694441FB3422E7838E24DEAE";
   
    // 待加密的字符串
    NSString *pwd = @"qwertyuioplkjhgfdsdfghjklkytrewertyuiocbfghhghgfhfghdfghdfghdghdfghdgfhgdhdtgggggggdfgfdgsfgfsdgsdfgsdfgfgsfgfdgfdfghfghdgfhdg";
    
    // 加密
    NSString *ctext = [GMSm2Utils encryptText:pwd publicKey:gPubkey];
    // 解密
    NSString *plainText = [GMSm2Utils decryptToText:ctext privateKey:gPrikey];
    
    NSLog(@"\n\nSM2加密>>>%@\nSM2解密>>>%@\n\n",ctext,plainText);
    
//    公钥私钥生成
    NSArray *newKey = [GMSm2Utils createKeyPair];
    // 公钥
    NSString *pubKey = newKey[0];
    // 私钥
    NSString *priKey = newKey[1];
    
    NSLog(@"\n\n生成公钥>>>%@\n生成私钥>>>>%@\n\n",pubKey,priKey);
    
    /*    sm2签名，无特殊约定的情况下，用户身份标识ID的长度为16字节，其默认值从左至右依次为：
        0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38
    0x31对应的asc是字符'1'，所以是默认id字符串1234567812345678
     */
    NSString *pubSign = [GMSm2Utils signText:@"这是待签名字符串" privateKey:priKey userID:@""];
    BOOL isRightSign = [GMSm2Utils verifyText:@"这是待签名字符串" signRS:pubSign publicKey:pubKey userID:@""];
    NSLog(@"\n\n签名>>>>>>>>%@\n验签>>>>>>>%d\n\n",pubKey,isRightSign);
}

- (void)SM3
{
    NSString *pwd = @"qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234";
    
    NSString *gm3Str = [GMSm3Utils hashWithString:pwd];
    
//  GM3 输出的是hex格式64位，即字节32位，即bit256位
    NSLog(@"\n\ngm3Str>>>>>%@\n\n",gm3Str);
    
//    NSLog(@"gm3Str>>>>>%@",[GMUtils hexToData:gm3Str]);
//    NSLog(@"gm3Str>>>>>%@",[[NSString alloc]initWithData:[GMUtils hexToData:gm3Str] encoding:NSUTF8StringEncoding]);
//    NSLog(@"gm3Str>>>>>%@",[GMUtils stringToHex:gm3Str]);
}

- (void)SM4
{
    NSString *key = [GMSm4Utils createSm4Key];
    NSLog(@"sm4key>>>>>%@",key);
    
/// 生成 SM4 密钥，秘钥长度为 hex格式32位 即字节16位，即bit256位

    NSString *sm4key = @"EB5AE847FB739DBDBD222C826140B7FA";
    
    NSString *pwd = @"qwer1234";
    
//    返回值：加密后的字符串，Hex 编码格式
    NSString *sm4E = [GMSm4Utils ecbEncryptText:pwd key:sm4key];
//    返回值：解密后的明文
    NSString *sm4D = [GMSm4Utils ecbDecryptText:sm4E key:sm4key];
    NSLog(@"\n\nsm4加密>>>>>%@\n解密>>>>>%@\n\n",sm4E,sm4D);
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
