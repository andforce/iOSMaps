//
//  AlertProgressViewController.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/26.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "AlertProgressViewController.h"

@interface AlertProgressViewController (){

    UIActivityIndicatorView *_indicator;
    
}
@end

@implementation AlertProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.center = CGPointMake(130.5, 65.5);

    _indicator.color = [UIColor grayColor];
    
    [self.view addSubview:_indicator];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_indicator startAnimating];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_indicator stopAnimating];
    
}

@end
