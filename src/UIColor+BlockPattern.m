//
//  UIColor+BlockPattern.m
//  BackgroundPatternExample
//
//  Created by Kim Hunter on 11/11/12.
//  Copyright (c) 2012 Kim Hunter. All rights reserved.
//

#import "UIColor+BlockPattern.h"

void drawPatternUsingBlock(void *info, CGContextRef c)
{
    void (^drawBlock)(CGContextRef c) = NULL;
    
#if __has_feature(objc_arc)
    drawBlock = (__bridge void (^)(CGContextRef))(info);
#else
    drawBlock = (void (^)(CGContextRef))(info);
#endif
    
    if (drawBlock != NULL)
    {
        drawBlock(c);
    }
}

void drawPatternUsingBlockRelease(void *info)
{
    if (info != NULL)
    {
        CFRelease(info);
    }
}


@implementation UIColor (KMBackgroundPattern)

+ (UIColor *)colorPatternWithSize:(CGSize)size andDrawingBlock:(void (^)(CGContextRef c))drawBlock
{
    return [self colorPatternWithSize:size
                             stepSize:size
                         tilingMethod:kCGPatternTilingConstantSpacingMinimalDistortion
                      andDrawingBlock:drawBlock];
}

+ (UIColor *)colorPatternWithSize:(CGSize)size
                         stepSize:(CGSize)stepSize
                     tilingMethod:(CGPatternTiling)tileMethod
                  andDrawingBlock:(void (^)(CGContextRef c))drawBlock
{
    void *infoBlock = NULL;
    CGPatternCallbacks patternCallbacks;
    patternCallbacks.version = 0;
    patternCallbacks.drawPattern = drawPatternUsingBlock;
    patternCallbacks.releaseInfo = drawPatternUsingBlockRelease;
    
    CGRect patternRect = CGRectZero;
    patternRect.size = size;
    
    // with arc on or off we are taking ownership
    // of this block, it will be released in the releaseInfo callback
#if __has_feature(objc_arc)
    infoBlock = (void *)CFBridgingRetain(drawBlock);
#else
    infoBlock = (void *)CFRetain(drawBlock);
#endif
    
    CGPatternRef pattern = CGPatternCreate(infoBlock, patternRect, CGAffineTransformIdentity, stepSize.width, stepSize.height, tileMethod, true, &patternCallbacks);
    CGColorSpaceRef patternColorSpace = CGColorSpaceCreatePattern(NULL);
    CGColorRef patColor = CGColorCreateWithPattern(patternColorSpace, pattern, (CGFloat []){1.0});
    
    UIColor *result = [UIColor colorWithCGColor:patColor];
    
    CGColorRelease(patColor);
    CGColorSpaceRelease(patternColorSpace);
    CGPatternRelease(pattern);
    
    return result;
}

@end
