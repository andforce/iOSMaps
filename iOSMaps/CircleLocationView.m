//
//  CircleLocationView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/10.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "CircleLocationView.h"

@implementation CircleLocationView


-(void)changeImageByUserTrackingMode:(long)mode{

    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"location_%1d", (int)mode]];
    [self setImage:image forState:UIControlStateNormal];
}

@end
