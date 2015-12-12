//
//  MapDrawerView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "MapDrawerView.h"

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
    }

}

@end
