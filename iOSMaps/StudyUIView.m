//
//  StudyUIView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/27.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "StudyUIView.h"
#import "CommonUtils.h"

@implementation StudyUIView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //
    
    UIImage *bgImage = [CommonUtils createImageWithColor:[UIColor whiteColor]];
    
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: CGSizeMake(3, 3)];
    [rectanglePath closePath];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    
    [bgImage drawInRect: self.bounds];
    CGContextRestoreGState(context);
}


-(void)didMoveToSuperview{
    
    
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 0.5;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // Start at the Top Left Corner
    [path moveToPoint:CGPointMake(0.0, 0.0)];
    
    // This is the extra point in the middle :) Its the secret sauce.
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) / 2.0)];
    
    // Move to the Top Right Corner
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0.0)];
    
    // Move to the Bottom Right Corner
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 1)];
    
    
    
    // Move to the Bottom Left Corner
    [path addLineToPoint:CGPointMake(0.0, CGRectGetHeight(self.frame))];
    
    [path addLineToPoint:CGPointMake(0.0, 0.0)];
    
    // Move to the Close the Path
    [path closePath];
    
    self.layer.shadowPath = path.CGPath;

    
}
@end
