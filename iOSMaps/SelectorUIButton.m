//
//  SelectorUIButton.m
//  iOSMaps
//
//  Created by WDY on 15/12/18.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SelectorUIButton.h"
#import "UIColor+MyColor.h"
#import "UIButton+BackgroundColor.h"

@implementation SelectorUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)didMoveToSuperview{
    [self setBackgroundColor:[UIColor colorWithButtonHighLight] forState:UIControlStateHighlighted];
}

@end
