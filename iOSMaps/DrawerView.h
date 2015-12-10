//
//  LeftDrawerView.h
//  iOSMaps
//
//  Created by WDY on 15/12/8.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerViewDelegate.h"

typedef CGFloat(^TouchX) (CGFloat x, CGFloat maxX);
@interface DrawerView : UIView



@property (nonatomic, weak) id<DrawerViewDelegate> delegate;

@property (nonatomic, assign) BOOL opened;
@property (nonatomic, assign) BOOL enadbled;

-(void)open;

-(void)close;

@end