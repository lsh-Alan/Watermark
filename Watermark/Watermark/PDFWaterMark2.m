//
//  PDFWaterMark2.m
//  Watermark
//
//  Created by Alan on 2020/11/6.
//

#import "PDFWaterMark2.h"
#import "UIImage+Watermark.h"

@implementation PDFWaterMark2
- (void)getUIImageFromPDFPage:(int)page_number filePath:(NSString*)pdfPath

{
    NSURL*filePath = [NSURL fileURLWithPath:pdfPath];

    //读取PDF原文件的大小
    CGPDFDocumentRef doc = CGPDFDocumentCreateWithURL((__bridge CFURLRef)filePath);

    CGPDFPageRef page =CGPDFDocumentGetPage(doc,1);

    CGRect pageRect = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);

    pageRect.origin=CGPointZero;

    pageRect.size.height= pageRect.size.height*2;

    pageRect.size.width= pageRect.size.width*2;

    //开启图片绘制 上下文
    UIGraphicsBeginImageContext(pageRect.size);

    CGContextRef  context =UIGraphicsGetCurrentContext();

    // 设置白色背景

    CGContextSetRGBFillColor(context,1.0,1.0,1.0,1.0);

    CGContextFillRect(context,pageRect);

    CGContextSaveGState(context);

    //进行翻转

    CGContextTranslateCTM(context, -pageRect.size.width/2, pageRect.size.height*1.5);

    CGContextScaleCTM(context,2, -2);

    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);

    CGContextSetRenderingIntent(context, kCGRenderingIntentDefault);

    CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, pageRect,0,true));

    CGContextDrawPDFPage(context,page);

    CGContextRestoreGState(context);

    UIImage *pdfImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    [self saveImage:pdfImage];
}

+ (NSString *)getWaterMarkPDFFilePath:(NSString *)pdfPath
{
    NSArray *images = [self getImagesWithPDFPath:pdfPath];
    if (!images || images.count == 0) {
        return pdfPath;
    }
    
    NSMutableArray *waterImages = [NSMutableArray array];
    for (NSInteger i = 0; i < images.count; i ++) {
        
        UIImage *image = images[i];
        UIImage *waterImage = [UIImage imageNamed:@"waterIcon"];

        UIImage *finalImage = [image addWaterImage:waterImage];
        if (finalImage) {
            [waterImages addObject:finalImage];
        }
    }
   
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    filePath = [filePath stringByAppendingPathComponent:pdfPath.lastPathComponent];
    
    //NSString *filePath = pdfPath;
    filePath = [self getPDF:waterImages PDFFilePath:filePath];
    return filePath;
}

+ (NSArray *)getImagesWithPDFPath:(NSString *)pdfPath
{
    NSURL*filePath = [NSURL fileURLWithPath:pdfPath];
    //读取PDF原文件的大小
    CGPDFDocumentRef doc = CGPDFDocumentCreateWithURL((__bridge CFURLRef)filePath);
    if (!doc) {
        return @[];
    }
    NSInteger num = CGPDFDocumentGetNumberOfPages(doc);
    NSMutableArray *pdfImageArray = [NSMutableArray array];
    for (NSInteger i = 1; i < num + 1; i++) {
        CGPDFPageRef page =CGPDFDocumentGetPage(doc,i);
    
        CGRect pageRect = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
        pageRect.origin = CGPointZero;
        pageRect.size.height = pageRect.size.height * 2;
        pageRect.size.width = pageRect.size.width * 2;
        
        //开启图片绘制 上下文
        UIGraphicsBeginImageContext(pageRect.size);
        
        CGContextRef context= UIGraphicsGetCurrentContext();
        
        //设置白色背景
        CGContextSetRGBFillColor(context,1.0,1.0,1.0,1.0);
        CGContextFillRect(context,pageRect);
        CGContextSaveGState(context);
        
        ////进行翻转
        CGContextTranslateCTM(context, -pageRect.size.width/2, pageRect.size.height*1.5);
        CGContextScaleCTM(context,2, -2);
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        CGContextSetRenderingIntent(context, kCGRenderingIntentDefault);
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, pageRect,0,true));
        CGContextDrawPDFPage(context,page);
        CGContextRestoreGState(context);
        UIImage *pdfImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (pdfImage) {
            [pdfImageArray addObject:pdfImage];
        }        
    }
    return pdfImageArray;
}

+ (NSString *)getPDF:(NSArray *)images PDFFilePath:(NSString *)pdfPath
{
    if (!images || images.count == 0) {
        return nil;
    }
        // CGRectZero 表示默认尺寸，参数可修改，设置自己需要的尺寸
        UIGraphicsBeginPDFContextToFile(pdfPath, CGRectZero, NULL);
        
        CGRect  pdfBounds = UIGraphicsGetPDFContextBounds();
        CGFloat pdfWidth  = pdfBounds.size.width;
        CGFloat pdfHeight = pdfBounds.size.height;
        
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            // 绘制PDF
            UIGraphicsBeginPDFPage();
            
//            CGFloat imageW = image.size.width;
//            CGFloat imageH = image.size.height;
            
            [image drawInRect:CGRectMake(0, 0, pdfWidth, pdfHeight)];
            
//            if (imageW <= pdfWidth && imageH <= pdfHeight)
//            {
//                CGFloat originX = (pdfWidth - imageW) / 2;
//                CGFloat originY = (pdfHeight - imageH) / 2;
//                [image drawInRect:CGRectMake(originX, originY, imageW, imageH)];
//            }
//            else
//            {
//                CGFloat width,height;
//
//                if ((imageW / imageH) > (pdfWidth / pdfHeight))
//                {
//                    width  = pdfWidth;
//                    height = width * imageH / imageW;
//                }
//                else
//                {
//                    height = pdfHeight;
//                    width = height * imageW / imageH;
//                }
//                [image drawInRect:CGRectMake((pdfWidth - width) / 2, (pdfHeight - height) / 2, width, height)];
//            }
        }];
        
        UIGraphicsEndPDFContext();
    
    return pdfPath;
}



- (void)saveImage:(UIImage*)image {
    UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:), (__bridge void*)self);

}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo

{

    if(!error) {

        NSLog(@"成功");
    }
    else{

        NSLog(@"失败");

    }
}


@end
