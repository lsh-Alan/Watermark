//
//  PDFWatermark.m
//  Watermark
//
//  Created by Alan on 2020/11/6.
//

#import "PDFWatermark.h"

@implementation PDFWatermark

- (void)footButtonAction

{
//    if ([self.downloadUrl isEqualToString:@""] || self.downloadUrl == nil || [self.downloadUrl isEqual:nil] || !self.downloadUrl) {
//
//       return;
//
//    }

    NSURL * url = [[NSURL alloc] initWithString:@""];

    CFURLRef ref = (__bridge CFURLRef)url;

    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL(ref);

    
    
    
    CFRelease(ref);

    NSInteger num = CGPDFDocumentGetNumberOfPages(pdf);

    CGImageRef imageRef = PDFPageToCGImage(1,pdf);

    UIImage *amg = [UIImage imageWithCGImage:imageRef];

    CGImageRelease(imageRef);

 

   //保存图片到相册

    UIImageWriteToSavedPhotosAlbum(amg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}

CGImageRef PDFPageToCGImage(size_t pageNumber, CGPDFDocumentRef document)

{
    CGPDFPageRef page = CGPDFDocumentGetPage (document, pageNumber);

    if(page)

    {
        CGRect pageSize =CGPDFPageGetBoxRect(page,kCGPDFMediaBox);

        CGContextRef outContext= CreateARGBBitmapContext (pageSize.size.width, pageSize.size.height);

        if(outContext)

        {
            CGContextDrawPDFPage(outContext, page);

            CGImageRef ThePDFImage= CGBitmapContextCreateImage(outContext);

            CFRelease(outContext);

            return ThePDFImage;

        }

    }

    return NULL;

}

CGContextRef CreateARGBBitmapContext (size_t pixelsWide, size_t pixelsHigh)

{
    CGContextRef    context = NULL;

    CGColorSpaceRef colorSpace;

    void *          bitmapData;

    unsigned long   bitmapByteCount;

    unsigned long   bitmapBytesPerRow;

    // Get image width, height. We’ll use the entire image.

    //  size_t pixelsWide = CGImageGetWidth(inImage);

    //  size_t pixelsHigh = CGImageGetHeight(inImage);

    // Declare the number of bytes per row. Each pixel in the bitmap in this

    // example is represented by 4 bytes; 8 bits each of red, green, blue, and

    // alpha.

    bitmapBytesPerRow   = (pixelsWide * 4);

    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);

    // Use the generic RGB color space.

    colorSpace =CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);

    if (colorSpace == NULL)

    {
        fprintf(stderr, "Error allocating color space\n");

        return NULL;

    }

    // Allocate memory for image data. This is the destination in memory

    // where any drawing to the bitmap context will be rendered.

    bitmapData = malloc( bitmapByteCount );

    if (bitmapData == NULL)

    {
        fprintf (stderr, "Memory not allocated!");

        CGColorSpaceRelease( colorSpace );

        return NULL;

    }

    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits

    // per component. Regardless of what the source image format is

    // (CMYK, Grayscale, and so on) it will be converted over to the format

    // specified here by CGBitmapContextCreate.

    context = CGBitmapContextCreate (bitmapData,

                                     pixelsWide,

                                     pixelsHigh,

                                     8,      // bits per component

                                     bitmapBytesPerRow,

                                     colorSpace,

                                     kCGImageAlphaPremultipliedFirst);

    if (context == NULL)

    {
        free (bitmapData);

        fprintf (stderr, "Context not created!");

    }

    // Make sure and release colorspace before returning

    CGColorSpaceRelease( colorSpace );

    return context;

}

 

// 功能：显示图片保存结果

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo

{
//

}
@end
