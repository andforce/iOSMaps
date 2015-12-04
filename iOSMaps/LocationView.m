//
//  LocationView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "LocationView.h"

@implementation LocationView

+(LocationView *)locationView: (UIView *) rootView{

    LocationView *locationView = [[NSBundle mainBundle]loadNibNamed:@"LocationView" owner:nil options:nil][0];
    
    locationView.frame = CGRectMake(rootView.frame.size.width - 50, rootView.frame.size.height - 50, locationView.frame.size.width, locationView.frame.size.height);
    
    return locationView;
}



@end
