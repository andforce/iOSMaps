//
//  LeftDrawerItem.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "LeftDrawerItem.h"
#import "CommonUtils.h"
#import "UIImage+Tint.h"
#import "UIColor+MyColor.h"


#define kMarginLeft 15

@implementation LeftDrawerItem


-(id)initWithLeftIcon:(NSString *)name andRightText:(NSString *)text{
    if (self = [super init]) {
        
        UIColor *blueHighLightColor = [UIColor colorWithBlueHighLight];
       
        UIImage *leftImage = [UIImage imageNamed:name];
        
        
        UIImage *leftImageTint = [leftImage imageWithTintColor:blueHighLightColor];
        
        [self setImage:leftImage forState:UIControlStateNormal];
        [self setImage:leftImageTint forState:UIControlStateHighlighted];
        [self setImage:leftImageTint forState:UIControlStateSelected];

        
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:blueHighLightColor forState:UIControlStateHighlighted];
        
        [self setTitleColor:blueHighLightColor forState:UIControlStateSelected];
        
        //[self setBackgroundColor:[UIColor grayColor]];
        
        
        UIImage *normalImage = [CommonUtils createImageWithColor:[UIColor whiteColor]];
        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
        
        
        UIImage *highLight = [CommonUtils createImageWithColor:[UIColor colorWithButtonHighLight]];
        [self setBackgroundImage:highLight forState:UIControlStateHighlighted];
        [self setBackgroundImage:highLight forState:UIControlStateSelected];

        
        
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
