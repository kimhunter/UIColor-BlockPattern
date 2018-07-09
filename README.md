UIColor-BlockPattern
===============
Want to use Quartz to draw a pattern, and keep your code simple ? Well, use this extension.

Description
----------------

Drawing a pattern as a color in Quartz means you need to implement a c function as a drawing callback then draw in that including all the other CoreGraphics setup. This extension makes it simple to do this with a block. See below how easy a standard grouped table view stripe background can be drawn.

```objc
[UIColor colorPatternWithSize:CGSizeMake(8.0,1.0) andDrawingBlock:^(CGRect bounds, CGContextRef c) {
    CGContextSetFillColorWithColor(c, [[UIColor colorWithRed:212/255.0 green:217/255.0 blue:226/255.0 alpha:1.0] CGColor]);
    CGContextFillRect(c, CGRectMake(0.0, 0.0, 8.0, 1.0));
    CGContextSetFillColorWithColor(c, [[UIColor colorWithRed:209/255.0 green:213/255.0 blue:223/255.0 alpha:1.0] CGColor]);
    CGContextFillRect(c, CGRectMake(5.0, 0.0, 3.0, 1.0));
}];
```

This Extension plays well with or without ARC.

How to use
--------------
Simply you could just copy the class in `/src` into your project. Or if you use kitspec or cocoapods, these will work to.

Example Code
---------------------
In the example project see MasterViewController.m setBackgroundForCellSelectionText for a couple of examples of how to test.


Tips
----

In a non arc environment where you want to define a variable outside the block remember
to copy and autorelease the block in the current scope. Like below would crash with an obscure warning, 

```objc
// don't do it like this
CGRect patternBounds = CGRectMake(0.0, 0.0, 20.0, 20.0);
backgroundColor = [UIColor colorPatternWithSize:patternBounds.size andDrawingBlock:^(CGRect bounds, CGContextRef c) {
    CGContextSetFillColorWithColor(c, [[UIColor redColor] CGColor]);
    CGContextFillEllipseInRect(c, patternBounds);
}];

```

So add a copy + autorelease to make sure your local variables have the correct references. like so
```objc
// do it like this
CGRect patternBounds = CGRectMake(0.0, 0.0, 20.0, 20.0);
backgroundColor = [UIColor colorPatternWithSize:patternBounds.size andDrawingBlock:[[^(CGRect bounds, CGContextRef c) {
    CGContextSetFillColorWithColor(c, [[UIColor redColor] CGColor]);
    CGContextFillEllipseInRect(c, patternBounds);
} copy] autorelease]];

//with the latest version you don't have to repeat yourself
CGRect patternSize = CGSizeMake(20.0, 20.0);
backgroundColor = [UIColor colorPatternWithSize:patternSize andDrawingBlock:^(CGRect bounds, CGContextRef c) {
    CGContextSetFillColorWithColor(c, [[UIColor redColor] CGColor]);
    CGContextFillEllipseInRect(c, bounds);
}];


```
