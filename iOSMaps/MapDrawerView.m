//
//  MapDrawerView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapDrawerView.h"
#import "LeftDrawerItem.h"

@interface MapDrawerView(){
    LeftDrawerItem *changeMapStype;
    LeftDrawerItem *cameraShow;
    LeftDrawerItem *settingButton;
    LeftDrawerItem *aboutButton;
}

@end


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
        changeMapStype = [[LeftDrawerItem alloc]initWithLeftIcon:@"ic_public_18pt" andRightText:@"卫星地图"];
        changeMapStype.tag = 1;
        [leftDrawer addSubview:changeMapStype];
        
        // 添加摄像头
        
        cameraShow = [[LeftDrawerItem alloc] initWithLeftIcon:@"ic_timelapse_18pt" andRightText:@"摄像头"];
        cameraShow.tag = 2;
        [leftDrawer addSubview:cameraShow];
        
        // 添加设置
        settingButton = [[LeftDrawerItem alloc] initWithLeftIcon:@"ic_settings_18pt" andRightText:@"设置"];
        settingButton.tag = 3;
        [leftDrawer addSubview:settingButton];\
        
        // 添加关于
        
        aboutButton = [[LeftDrawerItem alloc] initWithLeftIcon:@"ic_toys_18pt" andRightText:@"关于"];
        aboutButton.tag = 4;
        [leftDrawer addSubview:aboutButton];
        
    }

}

-(void)addOnItemClickListener:(OnClickListener)listener{
    [changeMapStype addOnClickListener:listener];
    [cameraShow addOnClickListener:listener];
    [settingButton addOnClickListener:listener];
    [aboutButton addOnClickListener:listener];
}
@end
