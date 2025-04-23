//
//  SecurityUtil.h
//  Smile
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "SecurityUtil.h"


#import "GTMBase64.h"

#import "NSData+AES.h"

#define Iv          @"" //偏移量,可自行修改

@implementation SecurityUtil

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
    
}

+ (NSString*)decodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSString*)encryptAES:(NSString*)string secretKey:(NSString*)secret {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [data AES256EncryptWithKey:secret];
    return [self encodeBase64Data:encryptedData];
}

#pragma mark - AES解密
//将带密码的data转成string
+(NSString*)decryptAES:(NSString *)string secretKey:(NSString*)secret {
    //    NSData *keyData =[[NSData alloc]initWithBase64EncodedString:[SharedMethod shared].secretAesKey options:0];
    //    NSString *keyStr =[[NSString alloc]initWithData:keyData encoding:NSUTF8StringEncoding];
    //base64解密
    NSData *decodeBase64Data=[GTMBase64 decodeString:string];
    NSData *decryData = [decodeBase64Data AES256DecryptWithKey:secret];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
//    if (str==nil||str.length==0) {
//        str= [[NSString alloc] initWithData:decryData encoding:enc];
//    }
    return str;
}

@end
