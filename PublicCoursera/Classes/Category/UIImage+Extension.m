//
//  UIImage+Extension.m
//  Snowing
//
//  Created by WXF on 15/1/16.
//  Copyright (c) 2015年 WXF. All rights reserved.
//

#import "UIImage+Extension.h"
#import <UIKit/UIKit.h>
@implementation UIImage (Extension)

+(UIImage *)image:(UIImage *)img scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
//    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+(UIImage *)image:(UIImage *)img scale:(CGFloat)scale{

    CGSize size=CGSizeMake(img.size.width*scale, img.size.height*scale);
    return [self image:img scaleToSize:size];

}


#pragma mark -  遮罩
/**
 *  使用imge 作为另一个 imge的 遮罩 返回遮罩后的img
 *  http://stackoverflow.com/questions/5757386/how-to-mask-an-uiimageview
 *  @param image
 *  @param maskImage
 *
 *  @return
 */

+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
    
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,[UIScreen mainScreen].scale); {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*) createImageWithColor:(UIColor*) color
{
    return [UIImage imageWithColor:color size:CGSizeMake(10, 10)];
}

@end
