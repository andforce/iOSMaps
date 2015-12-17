//
//  MapScrollSetttingViewController.m
//  iOSMaps
//
//  Created by WDY on 15/12/17.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapScrollSetttingViewController.h"

@interface MapScrollSetttingViewController ()

@end

@implementation MapScrollSetttingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenFrame = [ UIScreen mainScreen ].bounds;
    
    // 设置顶部的布局
    CGRect topFrame = _topBanner.frame;
    topFrame.size.width = screenFrame.size.width;
    _topBanner.frame = topFrame;
    
    
    // 设置SScrollView的布局
    CGRect scrollFrame = CGRectMake(0, topFrame.size.height, screenFrame.size.width, screenFrame.size.height - topFrame.size.height);
    
    _scrollView.frame = scrollFrame;
//    
//    _scrollView.scrollEnabled = YES;
//    _scrollView.bounces = YES;
    
    
    
    UIEdgeInsets s = _scrollView.contentInset;
    UIView * lastView = _scrollView.subviews.lastObject;
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%@", _scrollView.subviews);
    s.bottom = lastView.frame.origin.y + lastView.frame.size.height + 10;
    
    _scrollView.contentInset = s;
    
}


@end
