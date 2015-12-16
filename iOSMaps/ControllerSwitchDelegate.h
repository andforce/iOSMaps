//
//  ControllerSwitchDelegate.h
//  iOSMaps
//
//  Created by WDY on 15/12/16.
//  Copyright © 2015年 andforce. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol ControllerSwitchDelegate<NSObject>

@required
-(void)switchToSettingController;
-(void)switchToMapController;

@end
