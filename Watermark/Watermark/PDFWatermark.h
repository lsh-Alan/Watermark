//
//  PDFWatermark.h
//  Watermark
//
//  Created by Alan on 2020/11/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PDFWatermark : NSObject

///pdf添加水印后的新文件路径
+ (NSString *)getWaterMarkPDFPathWithOriginalPDFPath:(NSString *)pdfPath;

///pdf转图片
+ (NSArray *)getImagesWithPDFPath:(NSString *)pdfPath;

///从pdf转过来的图片再次转pdf
+ (BOOL)setPDFFromPDFImages:(NSArray *)pdfimages TargetPDFPath:(NSString *)pdfPath;

///普通图片转pdf
+ (BOOL)setPDF:(NSArray *)images TargetPDFPath:(NSString *)pdfPath;

@end

NS_ASSUME_NONNULL_END
