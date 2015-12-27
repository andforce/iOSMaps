//
//  SearchTableViewCell.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/26.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "GrideSearchTableViewCell.h"
#import "CommonUtils.h"

@implementation GrideSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    
    CGFloat gaps = (width - 8 * 2 - height * 5) / 5.f;
    
    NSArray * views = self.subviews.firstObject.subviews;
    
    NSUInteger count = views.count;
    for (int i = 0; i < count; i++) {
        UIButton * view = views [i];
        CGRect currentFrame = view.frame;
        currentFrame.origin.x = 8 + gaps * i + CGRectGetHeight(currentFrame) * i;
        view.frame = currentFrame;
    }
    
    self.backgroundColor = [UIColor clearColor];
    
    
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


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

@end
