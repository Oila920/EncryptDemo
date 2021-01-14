//
//  GMEncryptVC.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/13.
//  Copyright © 2020 Oila. All rights reserved.
//Pass

#import "GMEncryptVC.h"
#import "GMObjC.h"

/* 公钥长度：是SM2曲线上的一个点，用横坐标和纵坐标两个分量来表示，记为（x，y），简记为Q，一个分量的长度是256位；
    SM2非压缩公钥格式字节串长度为65字节，压缩格式长度为33字节，若公钥y坐标最后一位为0，则首字节为0x02，否则为0x03。非压缩格式公钥首字节为0x04。
    公钥为Bit string类型，内容为04||X||Y，其中X和Y分别标识公钥的X分量和Y分量。其长度各为256位。
*/
// 公钥 除了开头的04：64字节 hex128 512位 hex格式
static NSString *sm2Pubkey = @"0408E3FFF9505BCFAF9307E665E9229F4E1B3936437A870407EA3D97886BAFBC9C624537215DE9507BC0E2DD276CF74695C99DF42424F28E9004CDE4678F63D698";

//  私钥是一个大于1且小于n-1的整数（n为SM2算法的阶），私钥为intger类型
//  私钥 32字节 64hex 256位 hex格式
static NSString *sm2Prikey = @"90F3A42B9FE24AB196305FD92EC82E647616C3A3694441FB3422E7838E24DEAE";

static NSString *sm4key = @"86617055488F644EAAC2D9C2C1217B15";


@interface GMEncryptVC ()

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (copy ,nonatomic) NSMutableString *textViewStr;

@end

@implementation GMEncryptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textViewStr = [[NSMutableString alloc]init];

    [self SM2EncryptBtnClicked:nil];
    
    [self SM2SignBtnClicked:nil];
    
    [self SM3HashBtnClicked:nil];
    
    [self SM4ECBEncryptBtnClicked:nil];
    
    [self SM4CBCEncryptBtnClicked:nil];
    
    [self createSm2KeyBtnClicked:nil];
    
    [self createSm4KeyBtnClicked:nil];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark SM2加解密
- (IBAction)SM2EncryptBtnClicked:(UIButton *)sender {
    
    NSString *pwd = @"qwertyuioplkjhgfdsdfghjklkytrewertyuiocbfghhghgfhfghdfghdfghdghdfghdgfhgdhdtgggggggdfgfdgsfgfsdgsdfgsdfgfgsfgfdgfdfghfghdgfhdg";
    
    // 加密
    NSString *ctext = [GMSm2Utils encryptText:pwd publicKey:sm2Pubkey];
    // 解密
    NSString *plainText = [GMSm2Utils decryptToText:ctext privateKey:sm2Prikey];
    
    NSLog(@"\n\n待加密字符串>>>%@\n\nSM2加密>>>%@\nSM2解密>>>%@\n\n",pwd,ctext,plainText);
    
    [self reloadTextViewStr:[NSString stringWithFormat:@"待加密字符串>>>%@\n\nSM2加密>>>%@\nSM2解密>>>%@\n\n",pwd,ctext,plainText]];

}
#pragma mark SM2 验签计算
- (IBAction)SM2SignBtnClicked:(UIButton *)sender {
    
    /*    sm2签名，无特殊约定的情况下，用户身份标识ID的长度为16字节，其默认值从左至右依次为：
        0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38
    0x31对应的asc是字符'1'，所以是默认id字符串1234567812345678
     */
    NSString *pwd = @"qwer";
    NSString *pubSign = [GMSm2Utils signText:pwd privateKey:sm2Prikey userID:@""];
    BOOL isRightSign = [GMSm2Utils verifyText:pwd signRS:pubSign publicKey:sm2Pubkey userID:@""];
    NSLog(@"\n\n待加密字符串>>>%@\n\n签名>>>>>>>>%@\n验签>>>>>>>%@\n\n",pwd,pubSign,isRightSign?@"验签通过":@"验签失败");
    
    [self reloadTextViewStr:[NSString stringWithFormat:@"待加密字符串>>>%@\n\n签名>>>>>>>>%@\n验签>>>>>>>%@\n\n",pwd,pubSign,isRightSign?@"验签通过":@"验签失败"]];

}
#pragma mark SM3验签计算
- (IBAction)SM3HashBtnClicked:(UIButton *)sender {
    
     NSString *pwd = @"qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234qwer1234";
        
        NSString *gm3Str = [GMSm3Utils hashWithString:pwd];
        
    //  GM3 输出的是hex格式64位，即字节32位，即bit256位
        NSLog(@"\n\n待加密字符串>>>%@\n\ngm3Str>>>>>%@\n\n",pwd,gm3Str);
    //    NSLog(@"gm3Str>>>>>%@",[GMUtils hexToData:gm3Str]);
    //    NSLog(@"gm3Str>>>>>%@",[[NSString alloc]initWithData:[GMUtils hexToData:gm3Str] encoding:NSUTF8StringEncoding]);
    //    NSLog(@"gm3Str>>>>>%@",[GMUtils stringToHex:gm3Str]);
    
    [self reloadTextViewStr:[NSString stringWithFormat:@"待加密字符串>>>%@\n\ngm3Str>>>>>%@\n\n",pwd,gm3Str]];

}
#pragma mark SM4ECB模式加解密
- (IBAction)SM4ECBEncryptBtnClicked:(UIButton *)sender {
    
    NSString *pwd = @"qwer1234qwer1234qwer1234qwer1234";
    
    NSString *sm4ECBE = [GMSm4Utils ecbEncryptText:pwd key:sm4key];

    NSString *sm4ECBD = [GMSm4Utils ecbDecryptText:sm4ECBE key:sm4key];

    NSLog(@"\n\n待加密字符串>>>%@\n\nsm4ECB加密>>>>>%@\nECB解密>>>>>%@\n\n",pwd,sm4ECBE,sm4ECBD);
    
    [self reloadTextViewStr:[NSString stringWithFormat:@"待加密字符串>>>%@\n\nsm4ECB加密>>>>>%@\nECB解密>>>>>%@\n\n",pwd,sm4ECBE,sm4ECBD]];
}
#pragma mark SM4CBC模式加解密
- (IBAction)SM4CBCEncryptBtnClicked:(UIButton *)sender {

    NSString *pwd = @"qwer1234qwer1234qwer1234qwer1234";

        //    CBC 模式需传入 32 字节 Hex 编码格式 ivec 字符串
    //    返回值：加密后的字符串，Hex 编码格式
        NSString *sm4E = [GMSm4Utils cbcEncryptText:pwd key:sm4key IV:@"600DB9DFD1FBED04435C7E0DF83B5112"];
    //    返回值：解密后的明文
        NSString *sm4D = [GMSm4Utils cbcDecryptText:sm4E key:sm4key IV:@"600DB9DFD1FBED04435C7E0DF83B5112"];
        NSLog(@"\n\n待加密字符串>>>%@\n\nsm4CBC加密>>>>>%@\nCBC解密>>>>>%@\n\n",pwd,sm4E,sm4D);
    
    [self reloadTextViewStr:[NSString stringWithFormat:@"待加密字符串>>>%@\n\nsm4CBC加密>>>>>%@\nCBC解密>>>>>%@\n\n",pwd,sm4E,sm4D]];

}
#pragma mark SM2公钥私钥生成
- (IBAction)createSm2KeyBtnClicked:(UIButton *)sender {

    NSArray *newKey = [GMSm2Utils createKeyPair];
    // 公钥
    NSString *pubKey = newKey[0];
    // 私钥
    NSString *priKey = newKey[1];
    
    NSLog(@"生成公钥>>>%@\n生成私钥>>>>%@\n\n",pubKey,priKey);
    
    [self reloadTextViewStr:[NSString stringWithFormat:@"生成公钥>>>%@\n生成私钥>>>>%@\n\n",pubKey,priKey]];
}
#pragma mark 生成 SM4 密钥，秘钥长度为 hex格式32位 即字节16位，即bit256位
- (IBAction)createSm4KeyBtnClicked:(UIButton *)sender {
    
    NSString *key = [GMSm4Utils createSm4Key];
    NSLog(@"\n\nsm4key>>>>>%@\n\n",key);
    
    [self reloadTextViewStr:[NSString stringWithFormat:@"sm4key>>>>>%@\n\n",key]];
}


- (void)reloadTextViewStr:(NSString *)str
{
    [_textViewStr insertString:[NSString stringWithFormat:@"%@\n--------------------------------\n",str] atIndex:0];
    _textView.text = _textViewStr;
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
