//
//  PDFWaterMark2.m
//  Watermark
//
//  Created by Alan on 2020/11/6.
//

#import "PDFWaterMark2.h"

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
