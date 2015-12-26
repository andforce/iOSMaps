//
//  ListGroup.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/26.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "ListGroup.h"
#import "SearchModel.h"
#import <UIKit/UIKit.h>

@implementation ListGroup



#pragma mark Impl
-(void)addChild:(NSString *)iconName name:(NSString *)name{
    SearchModel *module = [[SearchModel alloc]init];
    UIImage *icon = [UIImage imageNamed:name];
    module.iconImage = icon;
    
    module.nameStr = name;
    
    [self.childs addObject:module];
}
@end
