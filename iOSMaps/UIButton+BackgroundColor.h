//
//  UIButton+BackgroundColor.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^OnClickListener)();



@interface UIButton(BackgroundColor)

@property (nonatomic, assign) OnClickListener listener;


-(void) addOnClickListener: (OnClickListener) listener;

-(void)setBackgroundColor:(UIColor *) color forState:(UIControlState) state;

@end
