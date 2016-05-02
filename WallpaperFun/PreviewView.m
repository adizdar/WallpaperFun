//
//  PreviewView.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 25/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "PreviewView.h"

@interface PreviewView()
@property (strong, nonatomic) NSString *lightTheme;
@property (strong, nonatomic) NSString *darkTheme;
@end

@implementation PreviewView


#pragma mark - Lifecycle

- (instancetype) initWithImage:(UIImage *)image
{
    self = [super init];
    
    if (!self) return nil;
    
    [self setup];
    
    self.image = image;
    
    return self;
}

- (instancetype) initWithThemes: (NSString *)lightTheme
                      darkTheme: (NSString *)darkTheme
{
    self = [super init];
    
    if (!self) return nil;
    
    [self setup];
    
    self.image = [UIImage imageNamed: lightTheme];
    self.lightTheme = lightTheme;
    self.darkTheme = darkTheme;
    
    return self;
}

- (void)setup
{
    float height = [UIScreen mainScreen].bounds.size.height;
    float width = [UIScreen mainScreen].bounds.size.width;
    
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.frame = CGRectMake(0, 25, width, height-25);
    self.image = [UIImage imageNamed: @"lightTheme"];
}

#pragma mark - Custom Accessors

#pragma mark - Public

- (UIColor *)averageColor: (UIImage *)bgImage
{
    if (!bgImage) return nil;
    
    CGImageRef rawImageRef = bgImage.CGImage;
    
    // This function returns the raw pixel values
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(rawImageRef));
    const UInt8 *rawPixelData = CFDataGetBytePtr(data);
    
    NSUInteger imageHeight = CGImageGetHeight(rawImageRef);
    NSUInteger imageWidth  = CGImageGetWidth(rawImageRef);
    NSUInteger bytesPerRow = CGImageGetBytesPerRow(rawImageRef);
    NSUInteger stride = CGImageGetBitsPerPixel(rawImageRef) / 8;
    
    // Here I sort the R,G,B, values and get the average over the whole image
    unsigned int red   = 0;
    unsigned int green = 0;
    unsigned int blue  = 0;
    
    for (int row = 0; row < imageHeight; row++) {
        const UInt8 *rowPtr = rawPixelData + bytesPerRow * row;
        for (int column = 0; column < imageWidth; column++) {
            red    += rowPtr[0];
            green  += rowPtr[1];
            blue   += rowPtr[2];
            rowPtr += stride;
            
        }
    }
    
    CFRelease(data);
    
    CGFloat f = 1.0f / (255.0f * imageWidth * imageHeight);
    return [UIColor colorWithRed:f * red  green:f * green blue:f * blue alpha:1];
}

/** If the color is white we have result approx 3, 
    for black is approx 0 so if the result is higher than half than return light theme */
- (BOOL)isImageDark: (UIImage *)bgImage
{
    if (!bgImage) return nil;
    
    UIColor *color = [self averageColor: bgImage];
    return [UtillsClass red: color] + [UtillsClass blue: color] + [UtillsClass green: color] <= 1.4 ? true : false;
}

- (void)setPreviewImage: (UIImage *)bgImage
{
    if (!bgImage) return;

    [UIView transitionWithView: self
                      duration: 0.2f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        self.image = [self isImageDark: bgImage] ? [UIImage imageNamed: self.lightTheme] : [UIImage imageNamed: self.darkTheme];
                    }
                    completion: nil];
}

- (void)setLightAndDarkTheme: (NSString *)lightTheme
                   darkTheme: (NSString *)darkTheme
{
    [UIView transitionWithView: self
                      duration: 0.3f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        self.image = [UIImage imageNamed: lightTheme];
                    }
                    completion:^(BOOL finished) {
                        self.lightTheme = lightTheme;
                        self.darkTheme = darkTheme;
                    }];
}

#pragma mark - Private


// WHITE OR BLACK checkerx
//- (BOOL) checkIfImage:(UIImage *)someImage {
//    CGImageRef image = someImage.CGImage;
//    size_t width = CGImageGetWidth(image);
//    size_t height = CGImageGetHeight(image);
//    GLubyte * imageData = malloc(width * height * 4);
//    int bytesPerPixel = 4;
//    int bytesPerRow = bytesPerPixel * width;
//    int bitsPerComponent = 8;
//    CGContextRef imageContext =
//    CGBitmapContextCreate(
//                          imageData, width, height, bitsPerComponent, bytesPerRow, CGImageGetColorSpace(image),
//                          kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
//                          );
//
//    CGContextSetBlendMode(imageContext, kCGBlendModeCopy);
//    CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), image);
//    CGContextRelease(imageContext);
//
//    int byteIndex = 0;
//
//    BOOL imageExist = YES;
//    for ( ; byteIndex < width*height*4; byteIndex += 4) {
//        CGFloat red = ((GLubyte *)imageData)[byteIndex]/255.0f;
//        CGFloat green = ((GLubyte *)imageData)[byteIndex + 1]/255.0f;
//        CGFloat blue = ((GLubyte *)imageData)[byteIndex + 2]/255.0f;
//        CGFloat alpha = ((GLubyte *)imageData)[byteIndex + 3]/255.0f;
//        if( red != 1 || green != 1 || blue != 1 || alpha != 1 ){
//            imageExist = NO;
//            break;
//        }
//    }
//
//    return imageExist;
//}

@end
