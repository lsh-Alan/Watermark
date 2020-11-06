//
//  UIImage+Watermark.m
//  Watermark
//
//  Created by Alan on 2020/11/6.
//

#import "UIImage+Watermark.h"

@implementation UIImage (Watermark)

// 给图片添加右下角图片水印
- (UIImage *)addWaterImage:(UIImage *)waterImage
{
    CGFloat scale = 0.3;
    CGFloat margin = 5;
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX = self.size.width - waterW - margin;
    CGFloat waterY = self.size.height - waterH - margin;
    
    UIImage *image = [self addWaterImage:waterImage waterImageRect:CGRectMake(waterX, waterY, waterW, waterH)];
    return image;
}

// 给图片添加右下角文字水印
- (UIImage *)addWatermarkText:(NSString *)text
{
    CGFloat margin = 5;
    CGFloat waterW = 150;
    CGFloat waterH = 30;
    CGFloat waterX = self.size.width - waterW - margin;
    CGFloat waterY = self.size.height - waterH - margin;
    
    UIImage *image = [self addWatermarkText:text textRect:CGRectMake(waterX, waterY, waterW, waterH) attributedString:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]}];
    return image;
}

// 给图片添加图片水印
- (UIImage *)addWaterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect
{
    if (!waterImage) {
        return self;
    }
    
    //1.获取图片
    
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //3.绘制背景图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

// 给图片添加文字水印 point
- (UIImage *)addWatermarkText:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed
{
    if (!text) {
        return self;
    }
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.绘制图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

// 给图片添加文字水印 rect
- (UIImage *)addWatermarkText:(NSString *)text textRect:(CGRect)rect  attributedString:(NSDictionary * )attributed
{
    if (!text) {
        return self;
    }
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.绘制图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //添加水印文字
    [text drawInRect:rect withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}



@end
