//
//  SettingViewController.h
//  iOSMaps
//
//  Created by WDY on 15/12/16.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapViewController.h"

@interface SettingViewController : MapViewController


@property (nonatomic, strong) id<ControllerSwitchDelegate> controllerSwitchDelegate;

@property(nonatomic, assign) UIButton *button;

@end
