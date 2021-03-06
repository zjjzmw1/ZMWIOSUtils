//
//  NSString+IOSUtils.m
//  Toos
//
//  Created by xiaoming on 15/1/30.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "NSString+IOSUtils.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (IOSUtils)

#pragma mark - 判断字符串是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

#pragma mark - 去除两端空格
+(NSString *)removeTrimmingBlank:(NSString *)string{
    ///去除两端空格
    ///sender 是输入框里面的text。
    NSString *temp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return temp;
    
}

#pragma mark - 去除所有空格
+(NSString *)removeAllBlank:(NSString *)string{
    ///去所有的空格。
    ///string 是输入框里面的text。
    NSString *resultString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return resultString;
}

- (NSString*)md5String{
    if(self == nil || [self length] == 0){
        return @"";
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

- (id)jsonvalue{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    if(!data){
        NSLog(@"解析json字符串出错！");
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error){
        NSLog(@"解析json字符串出错！");
    }
    return result;
}

- (BOOL)stringContainsSubString:(NSString *)subString {
    NSRange aRange = [self rangeOfString:subString];
    if (aRange.location == NSNotFound) {
        return NO;
    }
    
    return YES;
}

- (BOOL)matchStringWithRegextes:(NSString*)regString{
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regString];
    BOOL result = [predicate evaluateWithObject:self];
    return result;
}

/**
 *  @brief
 *
 *  @param string 要转化成 16 进制 data 的 16 进制字符串
 *
 *  @return 16进制 data
 */
- (NSData*)hexData{

    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx + 2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

- (NSString*)digitString:(NSInteger)digit{
    NSString* string = [self copy];
    while (string.length < digit) {
         string = [@"0" stringByAppendingString:string];
    }
    return string;
}

- (BOOL)isEmptyString {
    if(self == nil){
        return YES;
    }
    if([self isKindOfClass:[[NSNull null] class]]){
        return YES;
    }
    if([self isEqualToString:@""]){
        return YES;
    }
    if([self isEqualToString:@"<null>"])
        return YES;
    if([self isEqualToString:@"(null)"])
        return YES;
    return NO;
}

#pragma mark ====去掉float类型数据后面的 无效的 0 ==========必须是有两个小数的时候才能用。=======.2f=======
+(NSString *)clipZero:(NSString *)string{
    if (!string) {
        return nil;
    }
    if ([string rangeOfString:@"."].location == NSNotFound) {
        return string;
    }
    
    for (int i = 0; i < 2; ++i) {
        if ([string hasSuffix:@"0"]) {
            string = [string substringToIndex:string.length - 1];
        }
    }
    if ([string hasSuffix:@"."]) {
        string = [string substringToIndex:string.length - 1];
    }
    return string;
}

#pragma mark - 获取当前时间的时间戳。
+(NSString *)getCurrentTimeString{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

@end
