//
//  MapDrawerView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapDrawerView.h"
#import "LeftDrawerItem.h"

@implementation MapDrawerView


-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    if (self.drawerType == DrawerIndexLeft) {
        UIImageView *leftDrawerTopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_drawer_bg"]];
        
        CGSize imageSize = leftDrawerTopView.image.size;
        NSLog(@"imageSize with:%f, height:%f", imageSize.width, imageSize.height);
        
        
        UIView * leftDrawer = [self findDrawerWithDrawerIndex:DrawerIndexLeft];
        
        CGRect topFrame = leftDrawerTopView.frame;
        topFrame.size.width = leftDrawer.frame.size.width;
        
        topFrame.size.height = leftDrawer.frame.size.width * (imageSize.height / imageSize.width);
        
        leftDrawerTopView.frame = topFrame;
        
        [leftDrawer addSubview:leftDrawerTopView];
        
        // 添加地图样式切换
        LeftDrawerItem *changeMapStype = [[LeftDrawerItem alloc]initWithLeftIcon:@"ic_public_18pt" andRightText:@"卫星地图"];
        
        [leftDrawer addSubview:changeMapStype];
        
        // 添加摄像头
        
        LeftDrawerItem *cameraShow = [[LeftDrawerItem alloc] initWithLeftIcon:@"ic_timelapse_18pt" andRightText:@"摄像头"];
        [leftDrawer addSubview:cameraShow];
        
        // 添加设置
        LeftDrawerItem *settingButton = [[LeftDrawerItem alloc] initWithLeftIcon:@"ic_settings_18pt" andRightText:@"设置"];
        [leftDrawer addSubview:settingButton];\
        
        // 添加关于
        
        LeftDrawerItem *aboutButton = [[LeftDrawerItem alloc] initWithLeftIcon:@"ic_toys_18pt" andRightText:@"关于"];
        [leftDrawer addSubview:aboutButton];
        
    }

}

@end
