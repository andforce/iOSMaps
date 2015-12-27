//
//  CornerUIView.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/27.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CornerStyle) {
    CornerStyleTop = 0,
    CornerStyleBottom,
    CornerStyleAll,
    CornerStyleNone
    
};

@interface CornerUIView : UIView

-(id)initWith:(CornerStyle)style frame:(CGRect)size backgroundColor:(UIColor*)color;
@end
