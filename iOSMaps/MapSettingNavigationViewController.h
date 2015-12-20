//
//  MapSettingNavigationViewController.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/20.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerSwitchDelegate.h"

@interface MapSettingNavigationViewController : UIViewController


@property (weak, nonatomic) IBOutlet UINavigationBar *settingNavigationBar;


@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

- (IBAction)backButtonClick:(id)sender;

@property (nonatomic, strong) id<ControllerSwitchDelegate> controllerSwitchDelegate;

-(void) switchSetting;


@end
