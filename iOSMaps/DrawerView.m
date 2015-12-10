//
//  LeftDrawerView.m
//  iOSMaps
//
//  Created by WDY on 15/12/8.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "DrawerView.h"

#define kEdge 5
#define kDefaultDrawerRatio 4/5
#define kMaxMaskAlpha 0.6f


@interface DrawerView(){
    UIView *_leftDrawerView;
    UIButton *_leftDrawerMaskView;
}

@end


@implementation DrawerView

-(id)init{
    if (self == [super init]) {
        [self initLeftDrawerAndMaskView];
        
        UIScreenEdgePanGestureRecognizer *edgePab = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handlerEdgePan:)];
        edgePab.edges = UIRectEdgeLeft;
        
        [self addGestureRecognizer:edgePab];
        
        [self setEnadbled:YES];

    }
    return self;
}


-(void)open{
    [self showLeftDrawerWithAdim];
}

-(void)close{
    [self hideLeftDrawerWithAnim];
}


-(void)didAddSubview:(UIView *)subview{
    NSLog(@"didAddSubview");
}

-(void)didMoveToSuperview{
    
    UIView *rootView = [self superview];
    
    self.frame = CGRectMake(0, 0, kEdge, rootView.frame.size.height);
    
    NSLog(@"didMoveToSuperview %f", rootView.frame.size.width);
    
    _leftDrawerMaskView.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);
    
    [rootView addSubview:_leftDrawerMaskView];
    
    // init Left Drawer
    CGFloat with = rootView.frame.size.width * kDefaultDrawerRatio;
    _leftDrawerView.frame = CGRectMake(- with, 0, with, rootView.frame.size.height);
    
    
    [rootView addSubview:_leftDrawerView];
}




- (void) showLeftDrawerWithAdim{
    
    [self setOpened:true];
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect currentRect = _leftDrawerView.frame;
        currentRect.origin.x = 0;
        _leftDrawerView.frame = currentRect;
        
        _leftDrawerMaskView.alpha =  kMaxMaskAlpha;
        
        _leftDrawerView.layer.shadowOpacity = 0.5f;
    } completion:^(BOOL finished) {
        if (_delegate != nil) {
            [_delegate drawerDidOpened];
        }
        [self setOpened:finished];
    }];

}


-(void) hideLeftDrawerWithAnim{
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect currentRect = _leftDrawerView.frame;
        currentRect.origin.x = -_leftDrawerView.frame.size.width;
        _leftDrawerView.frame = currentRect;
        
        _leftDrawerView.layer.shadowOpacity = 0.f;
        
        _leftDrawerMaskView.alpha =  0.0f;
    } completion:^(BOOL finished) {
        if (_delegate != nil) {
            [_delegate drawerDidClosed];
        }
        [self setOpened:!finished];
    }];
}


-(void) initLeftDrawerAndMaskView{

    _leftDrawerMaskView = [[UIButton alloc]init];
    _leftDrawerMaskView.backgroundColor = [UIColor blackColor];
    _leftDrawerMaskView.alpha = 0.0f;
    
    [_leftDrawerMaskView addTarget:self action:@selector(hideLeftDrawerWithAnim) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *maskPan = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(handleMaskPan:)];
    [_leftDrawerMaskView addGestureRecognizer:maskPan];
    
    
    
    _leftDrawerView = [[UIView alloc]init];
    

    _leftDrawerView.backgroundColor = [UIColor whiteColor];
    
    _leftDrawerView.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    _leftDrawerView.layer.shadowOpacity = 0.f;
    //设置View Shadow的偏移量
    _leftDrawerView.layer.shadowOffset = CGSizeMake(5.f, 0);
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [_leftDrawerView addGestureRecognizer:panGestureRecognizer];
    
    
}

-(void) showOrHideAfterPan: (UIPanGestureRecognizer*) recognizer{
    [recognizer setTranslation:CGPointZero inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim];
        } else{
            [self hideLeftDrawerWithAnim];
        }
    }
}

-(void) handlerEdgePan:(UIScreenEdgePanGestureRecognizer *) recognizer{
    if (![self enadbled]) {
        return;
    }
    [self handlePan:recognizer];
}

- (void) handleMaskPan:(UIPanGestureRecognizer*) recognizer{
    if (![self enadbled]) {
        return;
    }
    
    [self dragLeftDrawer:recognizer :^CGFloat(CGFloat x, CGFloat maxX) {
       return  x < maxX ? x : maxX;
    }];

    
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer{
    
    if (![self enadbled]) {
        return;
    }
    
    [self dragLeftDrawer:recognizer :^CGFloat(CGFloat x, CGFloat maxX) {
        return x > maxX ? maxX : x;
    }];
}

-(void) dragLeftDrawer:( UIPanGestureRecognizer *)recognizer : (TouchX) block{
    
    UIView * panView = [recognizer.view superview];
    
    CGPoint translation = [recognizer translationInView:panView];
    
    CGPoint currentCenter = _leftDrawerView.center;
    
    
    CGFloat x = currentCenter.x + translation.x;
    
    CGFloat maxX = _leftDrawerView.frame.size.width / 2;
    
    //currentCenter.x = x < maxX ? x : maxX;
    currentCenter.x = block(x, maxX);
    
    _leftDrawerView.center = currentCenter;
    
    if (translation.x > 0 ) {
        _leftDrawerView.layer.shadowOpacity = 0.5f;
    }
    
    _leftDrawerMaskView.alpha = (_leftDrawerView.center.x + maxX ) / (maxX * 2) * kMaxMaskAlpha;
    
    [recognizer setTranslation:CGPointZero inView:panView];
    
    [self showOrHideAfterPan:recognizer];
    
}

@end