//
//  ViewController.h
//  iOSMaps
//
//  Created by WDY on 15/12/4.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMapViewController.h"
#include "MapPresenter.h"


@interface ViewController : BaseMapViewController

@property (nonatomic , strong) MapPresenter * mapPresenter;


@end

