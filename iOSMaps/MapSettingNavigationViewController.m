//
//  MapSettingNavigationViewController.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/20.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapSettingNavigationViewController.h"

@interface MapSettingNavigationViewController (){
    
    CGRect orgTopFrame;
    
    CGRect orgScrollFrame;
    
    CGRect screenFrame;
}

@end

@implementation MapSettingNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenFrame = [ UIScreen mainScreen ].bounds;
    
    // 设置顶部的布局
    CGRect topFrame = _settingNavigationBar.frame;
    topFrame.size.height = 20 + 44;
    
    
    topFrame.size.width = screenFrame.size.width;
    topFrame.origin.y = - topFrame.size.height;
    _settingNavigationBar.frame = topFrame;
    
    orgTopFrame = topFrame;
    
    
    // 设置SScrollView的布局
    CGRect scrollFrame = CGRectMake(0, screenFrame.size.height, screenFrame.size.width, screenFrame.size.height - topFrame.size.height);
    
    _mainScrollView.frame = scrollFrame;
    
    orgScrollFrame = scrollFrame;
    
    
    
    UIEdgeInsets s = _mainScrollView.contentInset;
    UIView * lastView = _mainScrollView.subviews.lastObject;
    //    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%@", _scrollView.subviews);
    s.bottom = lastView.frame.origin.y + lastView.frame.size.height + 10;
    
    _mainScrollView.contentInset = s;
    
}



-(void)backButtonClick:(id)sender{
    
}

-(void)switchSetting{
    CGRect current = _settingNavigationBar.frame;
    current.origin.y = current.origin.y >= 0 ? current.origin.y - current.size.height : 0;
    _settingNavigationBar.frame = current;
    
    CGRect currentScroll = _mainScrollView.frame;
    currentScroll.origin.y = currentScroll.origin.y == screenFrame.size.height ? orgTopFrame.size.height : screenFrame.size.height;
    _mainScrollView.frame = currentScroll;
}

@end
