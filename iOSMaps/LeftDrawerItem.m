//
//  LeftDrawerItem.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "LeftDrawerItem.h"

@implementation LeftDrawerItem


-(id)initWithLeftIcon:(NSString *)name andRightText:(NSString *)text{
    if (self = [super init]) {
        
        
        UIImage *leftImage = [UIImage imageNamed:name];
        [self setImage:leftImage forState:UIControlStateNormal];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 5, 15)];
        
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 5, 30)];
        
    }
    
    return self;
}
@end
