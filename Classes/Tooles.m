//
//  Tooles.m
//  Vodka
//
//  Created by 小明 on 15-12-26.
//  Copyright (c) 2014年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "Tooles.h"
#import "UIColor+IOSUtils.h"

@implementation Tooles

#pragma mark - 下面两个方法可以存储自定义的对象---TMCache就不行。
+(BOOL)saveFileToLoc:(NSString *) fileName theFile:(id) file{
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [fileName stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString *filename=[Path stringByAppendingPathComponent:CachePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filename]) {
        if (! [fileManager createFileAtPath:filename contents:nil attributes:nil]) {
            NSLog(@"createFile error occurred");
        }
    }
    return  [file writeToFile:filename atomically:YES];
}

+(BOOL) getFileFromLoc:(NSString*)filePath into:(id)file {
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [filePath stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString *filename=[Path stringByAppendingPathComponent:CachePath];
    
    if ([file isKindOfClass:[NSMutableDictionary class]]) {
        [file setDictionary: [NSMutableDictionary dictionaryWithContentsOfFile:filename]];
        if ([file count]==0) {
            return NO;
        }
    }else if ([file isKindOfClass:[NSMutableArray class]]) {
        [file addObjectsFromArray: [NSMutableArray arrayWithContentsOfFile:filename]];
        if ([file count]==0) {
            return NO;
        }
    }else if ([file isKindOfClass:[NSData class]]) {
        file = [NSData dataWithContentsOfFile:filename];
        if ([file length] ==0) {
            return NO;
        }
    }
    
    return YES;
}

+(NSData *) getDataFileFromLoc:(NSString*)filePath into:(id)file {
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [filePath stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString *filename=[Path stringByAppendingPathComponent:CachePath];
    
    if ([file isKindOfClass:[NSData class]]) {
        file = [NSData dataWithContentsOfFile:filename];
        if ([file length] ==0) {
            return nil;
        }
        return file;
    }
    return nil;
    
}

+(BOOL)removeLoc:(NSString *)fileName{
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [fileName stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString *filename=[Path stringByAppendingPathComponent:CachePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filename]) {
        if ([fileManager removeItemAtPath:filename error:nil]) {
            return YES;
        }
        return NO;
    }
    return NO;
    
}

/**
 *  获取UILabel 、UIButton 、UIImageView的类方法汇总
 *
 *  @param frame     控件大小
 *  @param fontSize  字体大小
 *  @param alignment 对齐方式
 *  @param textColor 字体颜色
 *
 *  @return UILabel/UIButton/UIImageView
 */
#pragma mark - 获取UILabel 、UIButton 、UIImageView的类方法汇总
+(UILabel *)getLabel:(CGRect)frame fontSize:(float)fontSize alignment:(NSTextAlignment)alignment textColor:(NSString *)textColor{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:16];//默认是16
    if (fontSize > 0) {
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    label.textAlignment = alignment;
    
    label.textColor = [UIColor colorFromHexString:textColor];//例如：@"ffffff"
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

+(UIButton *)getButton:(CGRect)frame title:(NSString *)title titleColor:(NSString *)titleColor titleSize:(float)titleSize{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorFromHexString:titleColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    if (titleSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:titleSize];
    }
    return button;
}

+(UIImageView *)getImageView:(CGRect)frame cornerRadius:(float)cornerRadius {
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = frame;
    imageView.layer.cornerRadius = cornerRadius;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;     ///这个是取中间的一部分。。不压缩的。
    imageView.backgroundColor = [UIColor clearColor];
    return imageView;
}

#pragma mark ====点击textField的时候，上下移动View的通用方法========
+ (void) animateTextField: (UITextField *)textField up: (BOOL)up viewController:(UIViewController *)tempVC
{
    const int movementDistance = -(int)textField.tag;
    const float movementDuration = 0.3f;
    
    int movement = (up ? movementDistance: -movementDistance);
    
    [UIView beginAnimations:@"animateTextField" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    
    tempVC.view.frame = CGRectOffset(tempVC.view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
