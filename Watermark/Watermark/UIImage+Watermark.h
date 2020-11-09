//
//  UIImage+Watermark.h
//  Watermark
//
//  Created by Alan on 2020/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Watermark)

/// 给图片添加右下角图片水印
- (UIImage *)addWaterImage:(UIImage *)waterImage;

- (UIImage *)tempaddWaterImage:(UIImage *)waterImage;

/// 给图片添加右下角文字水印
- (UIImage *)addWatermarkText:(NSString *)text;

/// 给图片添加图片水印
- (UIImage *)addWaterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;

/// 水印 尺寸 旋转角度0~360类型 centerpoint
- (UIImage *)addWaterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect CenterPoint:(CGPoint)centerPoint Rotate:(CGFloat)rotateAngle;

/// 给图片添加文字水印 point
- (UIImage *)addWatermarkText:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed;

/// 给图片添加文字水印 rect
- (UIImage *)addWatermarkText:(NSString *)text textRect:(CGRect)rect  attributedString:(NSDictionary * )attributed;


@end

NS_ASSUME_NONNULL_END
