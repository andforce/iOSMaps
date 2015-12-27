//
//  ShadowTableView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/27.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "ShadowTableView.h"
#import <UIKit/UIKit.h>

@implementation ShadowTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    NSLog(@"drawRect ---->>");
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    const CGFloat PageCellBackgroundRadius = 1.0f;
    
    NSLog(@"show subviews ---->>  %@", self.subviews.firstObject);
    
    
    for(int i = 0; i < [self numberOfSections]; i++) {
        NSInteger viewTag = i + 123456;
        
        CGRect frameRect = [self rectForSection: i];
        
        NSLog(@"layoutSubviews ---->>  %f", self.sectionHeaderHeight);
        
        
        UIView* shadowBackgroundView = [self viewWithTag: viewTag];
        
        if (shadowBackgroundView) {
            if (!CGRectEqualToRect(frameRect, shadowBackgroundView.frame)) {
                shadowBackgroundView.frame = frameRect;
                
                
                
                CGRect shadowFrame = shadowBackgroundView.bounds;
                shadowFrame.origin.y += self.sectionHeaderHeight;
                shadowFrame.origin.x += self.leftAndRightMargin;
                
                shadowFrame.size.height = shadowFrame.size.height - self.sectionHeaderHeight - self.sectionFooterHeight;
                shadowFrame.size.width -= self.leftAndRightMargin * 2.f;
                
                
                CGRect headerFrame = [self headerViewForSection:i].frame;
                
                NSLog(@"layoutSubviews ---->>  %f   %f   %f  %f    %f     %f", shadowFrame.origin.x , shadowFrame.origin.y, shadowFrame.size.width, shadowFrame.size.height, CGRectGetHeight(headerFrame), CGRectGetWidth(headerFrame));
                
                
                CGPathRef shadowPath = [UIBezierPath bezierPathWithRoundedRect: shadowFrame
                                                             byRoundingCorners: UIRectCornerAllCorners
                                                                   cornerRadii: CGSizeMake(PageCellBackgroundRadius, PageCellBackgroundRadius)].CGPath;
                shadowBackgroundView.layer.shadowPath = shadowPath;
            }
            
            [self sendSubviewToBack: shadowBackgroundView];
        } else {
            shadowBackgroundView = [[UIView alloc] initWithFrame: frameRect];
            shadowBackgroundView.tag = viewTag;
            shadowBackgroundView.opaque = YES;
            shadowBackgroundView.backgroundColor = [UIColor clearColor];
            
            shadowBackgroundView.layer.shadowOpacity = 0.3;
            shadowBackgroundView.layer.shadowRadius = 3.f;
            shadowBackgroundView.layer.shadowColor = [[UIColor blackColor] CGColor];
            shadowBackgroundView.layer.shadowOffset = CGSizeMake(0.0, 1.0);
            
            CGRect shadowFrame = shadowBackgroundView.bounds;
            shadowFrame.origin.y += self.sectionHeaderHeight;
            shadowFrame.origin.x += self.leftAndRightMargin;
            
            shadowFrame.size.height = shadowFrame.size.height - self.sectionHeaderHeight - self.sectionFooterHeight;
            shadowFrame.size.width -= self.leftAndRightMargin * 2.f;

            
            CGRect headerFrame = [self headerViewForSection:i].frame;
            
            NSLog(@"layoutSubviews ---->>  %f   %f   %f  %f    %f     %f", shadowFrame.origin.x , shadowFrame.origin.y, shadowFrame.size.width, shadowFrame.size.height, CGRectGetHeight(headerFrame), CGRectGetWidth(headerFrame));

            
            CGPathRef shadowPath = [UIBezierPath bezierPathWithRoundedRect: shadowFrame
                                                         byRoundingCorners: UIRectCornerAllCorners
                                                               cornerRadii: CGSizeMake(PageCellBackgroundRadius, PageCellBackgroundRadius)].CGPath;
            shadowBackgroundView.layer.shadowPath = shadowPath;
            shadowBackgroundView.layer.shouldRasterize = YES;
            
            [self addSubview: shadowBackgroundView];
        }
    }
}

@end
