//
//  LocationView.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/5.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "CircleView.h"

#define kViewR 50
#define kViewMargin 25

@interface CircleView(){
    int _radius;
}

@end

@implementation CircleView

-(id)initWithCircleRadius:(int)radius{
    if (self = [super init]) {
        _radius = radius;
        [self initWithR:_radius];
    }

    return self;
}

-(id) init{
    if (self = [super init]) {
        _radius = kViewR;
        [self initWithR:_radius];
    }
    return self;
}

-(void)initWithR:(int)r{
    self.backgroundColor = [UIColor whiteColor];
    //设置View圆角
    self.layer.cornerRadius = r / 2.0;
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

-(void)didMoveToSuperview{
    
    UIView *rootView = [self superview];
    
    self.frame = CGRectMake(rootView.frame.size.width - _radius - kViewMargin, rootView.frame.size.height - _radius - kViewMargin, _radius,  _radius);
}

- (void) changeToHighlight: (CircleView *) sender{
    sender.layer.shadowOpacity = 0.7;
}

-(void) changeToNormal: (CircleView *) sender{
    sender.layer.shadowOpacity = 0.3;
}

- (IBAction)showMyLocation:(UIButton *)sender {
    
}




@end
