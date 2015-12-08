//
//  LocationView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "LocationView.h"

#define kViewR 50
#define kViewMargin 25

@implementation LocationView


-(id) init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        //设置View圆角
        self.layer.cornerRadius = kViewR / 2.0;
        // 阴影的颜色
        self.layer.shadowColor = [[UIColor blackColor]CGColor];
        // 阴影的透明度
        self.layer.shadowOpacity = 0.3f;
        
        //设置View Shadow的偏移量
        self.layer.shadowOffset = CGSizeMake(0, 0.5f);
        
        [self addTarget:self action:@selector(changeToHighlight:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(changeToNormal:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(changeToNormal:) forControlEvents:UIControlEventTouchDragOutside];
    }
    return self;

}

-(void)didMoveToSuperview{
    
    UIView *rootView = [self superview];
    
    self.frame = CGRectMake(rootView.frame.size.width - kViewR - kViewMargin, rootView.frame.size.height - kViewR - kViewMargin, kViewR,  kViewR);
}

- (void) changeToHighlight: (LocationView *) sender{
    sender.layer.shadowOpacity = 0.7;
}

-(void) changeToNormal: (LocationView *) sender{
    sender.layer.shadowOpacity = 0.3;
}

- (IBAction)showMyLocation:(UIButton *)sender {
    
}




@end
