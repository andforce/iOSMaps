//
//  MapSettingViewController.h
//  iOSMaps
//
//  Created by WDY on 15/12/16.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerSwitchDelegate.h"

@interface MapSettingViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIView *topBanner;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UITableView *settingTableView;

- (IBAction)backButtonClick:(id)sender;

@property (nonatomic, strong) id<ControllerSwitchDelegate> controllerSwitchDelegate;

@end
