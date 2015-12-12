//
//  LeftDrawerItem.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "LeftDrawerItem.h"

#define kMarginLeft 15

@implementation LeftDrawerItem


-(id)initWithLeftIcon:(NSString *)name andRightText:(NSString *)text{
    if (self = [super init]) {
        
        
        UIImage *leftImage = [UIImage imageNamed:name];
        [self setImage:leftImage forState:UIControlStateNormal];

        
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundColor:[UIColor grayColor]];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        
    }
    
    return self;
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    NSArray * childViews = self.superview.subviews;
    
    UIView * lastView = childViews[childViews.count - 2];
    
    CGRect lastFrame = lastView.frame;

    self.frame = CGRectMake(0, lastFrame.origin.y + lastFrame.size.height, self.superview.frame.size.width, 50);
    
    
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, kMarginLeft, 0, 0)];
    
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMarginLeft * 2, 0, 0)];
    
    
}
@end
