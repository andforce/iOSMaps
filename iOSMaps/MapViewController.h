//
//  ViewController.h
//  iOSMaps
//
//  Created by WDY on 15/12/4.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMapViewController.h"
#import "MapPresenter.h"
#import "ControllerSwitchDelegate.h"

@interface MapViewController : BaseMapViewController

@property (nonatomic , strong) MapPresenter * mapPresenter;
@property (nonatomic, strong) id<ControllerSwitchDelegate> controllerSwitchDelegate;


@end

