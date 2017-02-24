//
//  UIImage+WebPUtils.m
//  WebPTest
//
//  Created by long_ on 17/2/20.
//  Copyright © 2017年 long_. All rights reserved.
//

#import "UIImage+WebPUtils.h"
#import <UIImage+WebP.h>

///根据scale  获取图片取用优先顺序
static NSArray *_NSBundlePreferredScales() {
    static NSArray *scales;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        CGFloat screenScale = [[UIScreen mainScreen] scale];
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        }else if (screenScale <= 2){
            scales = @[@2,@3,@1];
        }else{
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}
static NSString *_NSStringByAppendingNameScale(NSString *string, CGFloat scale) {
    if (!string) return nil;
    if (fabs(scale - 1) <= __FLT_EPSILON__ || string.length == 0 || [string hasSuffix:@"/"]) return string.copy;
    return [string stringByAppendingFormat:@"@%@x", @(scale)];
}



@implementation UIImage (WebPUtils)

+ (nullable UIImage *)pa_imageNamed:(nonnull NSString *)name{
    NSLog(@"*******");
    if (!name) {
        return nil;
    }
    ///图片Bundle path
    NSString *path = @"";
    ///图片后缀 无为空字符串
    NSString *nameSuffix = name.pathExtension;
    if (nameSuffix.length > 0 && ![nameSuffix isEqualToString:@"webp"]) {
        return [UIImage pa_imageNamed:name];
    }
    ///图片名（去后缀）
    NSString *nameConten = name.stringByDeletingPathExtension;
    CGFloat imgScale = 1.0f;
    ///保存图片scale
    if ([nameConten hasSuffix:@"@2x"]) {
        imgScale = 2.0f;
    }else if ([nameConten hasSuffix:@"@3x"]){
        imgScale = 3.0f;
    }
    ///图片取得顺序偏好
    NSArray *scales = _NSBundlePreferredScales();
    
    for (NSNumber *scale in scales) {
        int s = scale.floatValue;
        NSString *scacleName = _NSStringByAppendingNameScale(nameConten, s);
        path = [[NSBundle mainBundle] pathForResource:scacleName ofType:@"webp"];
        if (path.length > 0) {
            if (s != 1) {
                imgScale = scale.floatValue;
            }
            break;
        }
    }
    if (!path) {
        return [UIImage pa_imageNamed:name];
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    //设置scale
    UIImage *webPimage = [UIImage sd_imageWithWebPData:data];
    [webPimage setValue:@(imgScale) forKey:@"scale"];
    return webPimage;
}

@end
