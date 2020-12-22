//
//  XQSHA256Util.h
//  EncryptDemo
//
//  Created by Oila on 2020/12/21.
//  Copyright © 2020 Oila. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XQSHA256Util : NSObject

+ (NSString *)sha256HashFor:(NSString *)input;

@end

NS_ASSUME_NONNULL_END
