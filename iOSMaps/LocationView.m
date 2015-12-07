//
//  LocationView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "LocationView.h"

#define kViewR 50
#define kViewMargin 25

@implementation LocationView

+(LocationView *)locationView: (UIView *) rootView{

    LocationView *shadowView=[[LocationView alloc] initWithFrame:CGRectMake(rootView.frame.size.width - kViewR - kViewMargin, rootView.frame.size.height - kViewR - kViewMargin, kViewR,  kViewR)];
    shadowView.backgroundColor = [UIColor whiteColor];
    
    //设置View圆角
    shadowView.layer.cornerRadius = kViewR / 2.0;
    // 阴影的颜色
    shadowView.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    shadowView.layer.shadowOpacity = 0.5f;
    //设置View Shadow的偏移量
    shadowView.layer.shadowOffset = CGSizeMake(0, 0.5f);

    return shadowView;
}

- (IBAction)showMyLocation:(UIButton *)sender {
    
}




@end
