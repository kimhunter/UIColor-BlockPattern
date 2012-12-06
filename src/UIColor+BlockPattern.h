//
//  UIColor+BlockPattern.h
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

#import <UIKit/UIKit.h>
/** Provides easy drawing of patterns as a UIColor with blocks */
@interface UIColor (BlockPattern)
    /** Create a pattern bassed color with basic options

        @param size Size of pattern tile
        @param drawBlock block taking a bounds and context to draw in
        @return color based on pattern
    */
+ (UIColor *)colorPatternWithSize:(CGSize)size andDrawingBlock:(void (^)(CGRect bounds, CGContextRef c))drawBlock;

    /** Create a pattern bassed color

        @param size size of pattern tile
        @param stepSize displacement between tiles
        @param tilingMethod tiling distortion method
        @param drawBlock block taking a bounds and context to draw in
    */
+ (UIColor *)colorPatternWithSize:(CGSize)size
                         stepSize:(CGSize)stepSize
                     tilingMethod:(CGPatternTiling)tileMethod
                  andDrawingBlock:(void (^)(CGRect bounds, CGContextRef c))drawBlock;

@end
