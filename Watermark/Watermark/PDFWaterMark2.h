//
//  PDFWaterMark2.h
//  Watermark
//
//  Created by Alan on 2020/11/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PDFWaterMark2 : NSObject

- (void)getUIImageFromPDFPage:(int)page_number filePath:(NSString*)pdfPath;

@end

NS_ASSUME_NONNULL_END
