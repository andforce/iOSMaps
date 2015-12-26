//
//  GrideGroup.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/26.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "GrideGroup.h"
#import <UIKit/UIKit.h>
#import "GrideSearchModule.h"

@implementation GrideGroup

-(void)addChild:(NSString *)name{
    
    GrideSearchModule *grideModule = [[GrideSearchModule alloc]init];
    grideModule.name = name;
    
    [self.childs addObject:grideModule];
}

@end
