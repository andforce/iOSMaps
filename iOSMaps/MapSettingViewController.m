//
//  MapSettingViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/16.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapSettingViewController.h"

@interface MapSettingViewController ()<UITableViewDataSource>

@end

@implementation MapSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _settingTableView.dataSource = self;
    
    
    
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height - %f", rectStatus.size.height);   // 高度
    
    CGFloat size = _topBanner.frame.size.height - rectStatus.size.height;
    
    CGRect backBtnFrame = CGRectMake(0, rectStatus.size.height, size, size);
 
    _backButton.frame = backBtnFrame;

    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=@"1111";
    cell.detailTextLabel.text=@"2222222";
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (IBAction)backButtonClick:(id)sender {
    if (_controllerSwitchDelegate != nil) {
        [_controllerSwitchDelegate switchToMapController];
    }
}
@end
