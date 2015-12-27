//
//  CornerUIView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/27.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "CornerUIView.h"
#import "CommonUtils.h"

@implementation CornerUIView{
    CornerStyle _style;
    UIColor *_bgcolor;
}


-(id)initWith:(CornerStyle)style frame:(CGRect)size backgroundColor:(UIColor *)color{
    if (self = [super init]) {
        self.frame = size;
        _bgcolor = color;
        
        _style = style;
        
        if (_style == CornerStyleNone) {
            self.backgroundColor = _bgcolor;
        } else{
            self.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_style == CornerStyleNone) {
        return;
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIImage *bgImage = [CommonUtils createImageWithColor:_bgcolor];
    

    UIRectCorner corner = UIRectCornerAllCorners;
    
    if (_style == CornerStyleTop) {
        corner = UIRectCornerTopLeft | UIRectCornerTopRight;
    } else if (_style == CornerStyleBottom){
        corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    
    
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: corner cornerRadii: CGSizeMake(3, 3)];
    
    
    
    [rectanglePath closePath];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    
    [bgImage drawInRect: self.bounds];
    CGContextRestoreGState(context);
}





@end
