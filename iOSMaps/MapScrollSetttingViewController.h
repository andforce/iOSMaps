//
//  MapScrollSetttingViewController.h
//  iOSMaps
//
//  Created by WDY on 15/12/17.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ControllerSwitchDelegate.h"


@interface MapScrollSetttingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *topBanner;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)backButtonClick:(id)sender;

@property (nonatomic, strong) id<ControllerSwitchDelegate> controllerSwitchDelegate;

-(void) switchSetting;

@end
