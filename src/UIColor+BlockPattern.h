//
//  UIColor+BlockPattern.h
//  BackgroundPatternExample
//
//  Created by Kim Hunter on 11/11/12.
//  Copyright (c) 2012 Kim Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BlockPattern)

+ (UIColor *)colorPatternWithSize:(CGSize)size andDrawingBlock:(void (^)(CGContextRef c))drawBlock;
+ (UIColor *)colorPatternWithSize:(CGSize)size
                         stepSize:(CGSize)stepSize
                     tilingMethod:(CGPatternTiling)tileMethod
                  andDrawingBlock:(void (^)(CGContextRef c))drawBlock;

@end
