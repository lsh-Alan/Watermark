//
//  ViewController.m
//  Watermark
//
//  Created by Alan on 2020/11/6.
//

#import "ViewController.h"
#import "UIImage+Watermark.h"
#import "PDFWatermark.h"
#import <WebKit/WebKit.h>
@interface ViewController ()

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 350, 60, 60)];
    [button1 setTitle:@"图片" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [UIColor grayColor];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 350, 60, 60)];
    [button2 setTitle:@"文字" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:self action:@selector(addText) forControlEvents:UIControlEventTouchUpInside];
    button2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button2];
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(60, 250, 200, 200)];
//    view.backgroundColor = [UIColor redColor];
//    [self.imageView addSubview:view];
    
}

- (void)addImage
{
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604664556305&di=8e5c4ed98672b60478cdb85d57c07e99&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F64%2F52%2F01300000407527124482522224765.jpg"]]];
    
    UIImage *waterImage = [UIImage imageNamed:@"waterIcon"];
    
    UIImage *finalImage = [image addWaterImage:waterImage];
    
    finalImage = [finalImage tempaddWaterImage:waterImage];
    
    self.imageView.image = finalImage;
}

- (void)addText
{
    
    
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604664556305&di=8e5c4ed98672b60478cdb85d57c07e99&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F64%2F52%2F01300000407527124482522224765.jpg"]]];
    
        UIImage *finalImage = [image addWatermarkText:@"水印"];
        self.imageView.image = finalImage;
    
    NSString  *url = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
    
    NSString *filePath = [PDFWatermark getWaterMarkPDFPathWithOriginalPDFPath:url];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    
    NSURL *file = [NSURL fileURLWithPath:filePath];
    
    UIActivityViewController * activity = [[UIActivityViewController alloc]initWithActivityItems:@[data,file]
                                                                           applicationActivities:nil];
    
    
    
    [self presentViewController:activity animated:YES completion:nil];
    
}



@end
