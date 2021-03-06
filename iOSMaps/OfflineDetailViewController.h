//
//  OfflineDetailViewController.h
//  OfficialDemo3D
//
//  Created by xiaoming han on 14-5-5.
//  Copyright (c) 2014年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MAMapView;

@interface OfflineDetailViewController : UIViewController

@property (nonatomic, strong) MAMapView *mapView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UINavigationBar *offlineNavigationBar;

- (IBAction)backClick:(UIBarButtonItem *)sender;

@end
