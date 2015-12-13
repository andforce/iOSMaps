//
//  MapDrawerView.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "DrawerView.h"
#import "UIButton+BackgroundColor.h"

typedef NS_ENUM(NSInteger, DrawerItemType) {
    DrawerItemTypeSatellite = 100,
    DrawerItemTypeCamera,
    DrawerItemTypeSetting,
    DrawerItemTypeAbout
    
};


@interface MapDrawerView : DrawerView

-(void)addOnItemClickListener:(OnClickListener)listener;

@end
