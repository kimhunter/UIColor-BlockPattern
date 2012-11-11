//
//  UIColor+BlockPattern.m
//
// Created by Kim Hunter on 11/11/12.
// Copyright (c) 2012 Kim Hunter 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
