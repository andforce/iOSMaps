//
//  UIButton+BackgroundColor.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "UIButton+BackgroundColor.h"
#import "CommonUtils.h"
#import <objc/runtime.h>

static const void *OnClickListenerKey = &OnClickListenerKey;

@implementation UIButton(BackgroundColor)

@dynamic listener;

-(OnClickListener)listener{
    return objc_getAssociatedObject(self, OnClickListenerKey);
}

-(void)setListener:(OnClickListener)listener{
    objc_setAssociatedObject(self, OnClickListenerKey, listener, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) setBackgroundColor:(UIColor *)color forState:(UIControlState)state{
    [self setBackgroundImage:[CommonUtils createImageWithColor:color] forState:state];
}


-(void)addOnClickListener:(OnClickListener)listener{
    self.listener = listener;
    [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)click{
    self.listener();
}

@end
