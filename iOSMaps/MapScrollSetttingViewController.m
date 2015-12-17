//
//  MapScrollSetttingViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/17.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapScrollSetttingViewController.h"

@interface MapScrollSetttingViewController (){
    CGRect orgTopFrame;
    
    CGRect orgScrollFrame;
    
    CGRect screenFrame;
}

@end

@implementation MapScrollSetttingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenFrame = [ UIScreen mainScreen ].bounds;
    
    // 设置顶部的布局
    CGRect topFrame = _topBanner.frame;
    topFrame.size.width = screenFrame.size.width;
    topFrame.origin.y = - topFrame.size.height;
    _topBanner.frame = topFrame;
    
    orgTopFrame = topFrame;
    
    
    // 设置SScrollView的布局
    CGRect scrollFrame = CGRectMake(0, screenFrame.size.height, screenFrame.size.width, screenFrame.size.height - topFrame.size.height);
    
    _scrollView.frame = scrollFrame;
    
    orgScrollFrame = scrollFrame;
    
    
    
    UIEdgeInsets s = _scrollView.contentInset;
    UIView * lastView = _scrollView.subviews.lastObject;
//    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%@", _scrollView.subviews);
    s.bottom = lastView.frame.origin.y + lastView.frame.size.height + 10;
    
    _scrollView.contentInset = s;
    
}

-(void)switchSetting{
    CGRect current = _topBanner.frame;
    current.origin.y = current.origin.y >= 0 ? current.origin.y - current.size.height : 0;
    _topBanner.frame = current;
    
    CGRect currentScroll = _scrollView.frame;
    currentScroll.origin.y = currentScroll.origin.y == screenFrame.size.height ? orgTopFrame.size.height : screenFrame.size.height;
    _scrollView.frame = currentScroll;
}

- (IBAction)backButtonClick:(id)sender {
    if (_controllerSwitchDelegate != nil) {
        [_controllerSwitchDelegate switchToMapController];
    }
}
@end
