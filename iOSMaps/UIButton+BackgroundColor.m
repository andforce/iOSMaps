//
//  UIButton+BackgroundColor.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "UIButton+BackgroundColor.h"
#import "CommonUtils.h"


@implementation UIButton(BackgroundColor)

-(void) setBackgroundColor:(UIColor *)color forState:(UIControlState)state{
    [self setBackgroundImage:[CommonUtils createImageWithColor:color] forState:state];
}

@end
