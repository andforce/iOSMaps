//
//  SearchView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

+ (SearchView *)searvchView{
    return [[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:nil options:nil][0];
}

@end
