//
//  NSString+IOSUtils.m
//  Toos
//
//  Created by xiaoming on 15/1/30.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IOSUtils)


/**
 *  判断字符串是否含表情
 *
 *  @param string 原有字符串
 *
 *  @return 返回是否有标题
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  去除两端空格
 *
 *  @param string 原字符串
 *
 *  @return 去除两端空格的字符串
 */
+(NSString *)removeTrimmingBlank:(NSString *)string;

/**
 *  去除所有空格
 *
 *  @param string 原始字符串
 *
 *  @return 返回没有空格的字符串
 */
+(NSString *)removeAllBlank:(NSString *)string;


/**
 *  @brief  将NSString进行16位小写MD5加密.
 *
 *  @return 加密后的字符串.
 */
- (NSString*)md5String;

/**
 *  @brief  把 JSON 字符串转为 NSDictionary 或者 NSArray
 *
 *  @return NSDictionary或NSArray的对象(需要强制转换)
 */
- (id)jsonvalue;

/**
 *  @brief  判断字符串是否为空
 *
 *  @return YES:空字符串， NO:非空字符串.
 */
- (BOOL)isEmptyString;

/**
 *  @brief 判断NSString是否包含另一个字符串
 *
 *  @param subString 子字符串
 *
 *  @return YES:包含，NO:不包含.
 */
- (BOOL)stringContainsSubString:(NSString *)subString;

/**
 *  @brief 字符串匹配正则表达式
 *
 *  @param regString 正则表达式
 *
 *  @return YES:匹配， NO:不匹配.
 */
- (BOOL)matchStringWithRegextes:(NSString*)regString;

/**
 *  @brief  将16进制字符串转换为NSData.
 *
 *  @return 16进制 data
 */
- (NSData*)hexData;

- (NSString*)digitString:(NSInteger)digit;

/**
 *  去掉float类型数据后面的 无效的 0 ==========必须是有两个小数的时候才能用。=======.2f=======  完整性有待提高
 *
 *  @param string 原始字符串
 *
 *  @return 去掉无效的 0 后的字符串
 */
+(NSString *)clipZero:(NSString *)string;

/**
 *  获取当前时间的时间戳。
 *
 *  @return 时间戳
 */
+(NSString *)getCurrentTimeString;

@end
