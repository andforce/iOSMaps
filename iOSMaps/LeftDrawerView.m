//
//  LeftDrawerView.m
//  iOSMaps
//
//  Created by WDY on 15/12/8.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "LeftDrawerView.h"

@interface LeftDrawerView(){
    UIView *_leftDrawerView;
    UIButton *_leftDrawerMaskView;
}

@end


@implementation LeftDrawerView

-(id)init{
    if (self == [super init]) {
        [self initLeftDrawerAndMaskView];
        
        UIScreenEdgePanGestureRecognizer *edgePab = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handlerEdgePan:)];
        edgePab.edges = UIRectEdgeLeft;
        
        [self addGestureRecognizer:edgePab];

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
    
    self.frame = CGRectMake(0, 0, 5, rootView.frame.size.height);
    
    NSLog(@"didMoveToSuperview %f", rootView.frame.size.width);
    
    _leftDrawerMaskView.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);
    
    [rootView addSubview:_leftDrawerMaskView];
    
    // init Left Drawer
    CGFloat with = rootView.frame.size.width * 2 / 3;
    _leftDrawerView.frame = CGRectMake(- with, 0, with, rootView.frame.size.height);
    
    
    [rootView addSubview:_leftDrawerView];
}


-(void) handlerEdgePan:(UIScreenEdgePanGestureRecognizer *) recognizer{
    
    CGPoint translation = [recognizer translationInView:_leftDrawerView];
    
    CGFloat x = _leftDrawerView.center.x + translation.x;
    
    if (x > self.superview.frame.size.width / 3.0f) {
        return;
    }
    
    if (translation.x > 0) {
        _leftDrawerView.layer.shadowOpacity = 0.5f;
    }
    
    [UIView animateWithDuration:0.05 animations:^{
        CGPoint p = recognizer.view.center;
        p.x = x;
        _leftDrawerView.center = p;
        
        _leftDrawerMaskView.alpha = (_leftDrawerView.frame.origin.x + _leftDrawerView.frame.size.width) / _leftDrawerView.frame.size.width * 0.6f;
        
    }];
    
    
    [recognizer setTranslation:CGPointZero inView:_leftDrawerView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:_leftDrawerView];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim];
        } else{
            [self hideLeftDrawerWithAnim];
        }
    }
    
    
    NSLog(@"handlerEdgePan");
}

- (void) showLeftDrawerWithAdim{
    [UIView beginAnimations:nil context:nil];
    CGRect currentRect = _leftDrawerView.frame;
    currentRect.origin.x = 0;
    _leftDrawerView.frame = currentRect;
    
    _leftDrawerMaskView.alpha =  0.6f;
    
    _leftDrawerView.layer.shadowOpacity = 0.5f;
    
    [UIView commitAnimations];
}


-(void) hideLeftDrawerWithAnim{
    [UIView beginAnimations:nil context:nil];
    CGRect currentRect = _leftDrawerView.frame;
    currentRect.origin.x = -_leftDrawerView.frame.size.width;
    _leftDrawerView.frame = currentRect;
    
    _leftDrawerView.layer.shadowOpacity = 0.f;
    
    _leftDrawerMaskView.alpha =  0.0f;
    [UIView commitAnimations];
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



- (void) handleMaskPan:(UIPanGestureRecognizer*) recognizer{
    
    
    CGPoint translation = [recognizer translationInView:_leftDrawerView];
    
    
    CGFloat x = _leftDrawerView.center.x + translation.x ;
    
    NSLog(@" trans x = %f,    center = %f       touch x = %f", x, _leftDrawerView.center.x, translation.x);
    if (x < _leftDrawerView.frame.size.width / 2.0f) {
        
        [UIView animateWithDuration:0.05 animations:^{
            CGPoint p = recognizer.view.center;
            p.x = x;
            _leftDrawerView.center = p;
            
            _leftDrawerMaskView.alpha = (_leftDrawerView.frame.origin.x + _leftDrawerView.frame.size.width) / _leftDrawerView.frame.size.width * 0.6f;
            
            NSLog(@" trans x =============================%f" , _leftDrawerView.frame.origin.x);
            
            
        }];
        
    }
    
    [recognizer setTranslation:CGPointZero inView:_leftDrawerView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:_leftDrawerView];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim];
        } else{
            [self hideLeftDrawerWithAnim];
        }
    }
    
}


- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:recognizer.view];
    CGFloat x = recognizer.view.center.x + translation.x;
    if (x > self.superview.frame.size.width / 3.0f) {
        return;
    }
    
    if (translation.x >0 ) {
        _leftDrawerView.layer.shadowOpacity = 0.5f;
    }
    
    [UIView animateWithDuration:0.05 animations:^{
        CGPoint p = recognizer.view.center;
        p.x = x;
        _leftDrawerView.center = p;
        _leftDrawerMaskView.alpha = (_leftDrawerView.frame.origin.x + _leftDrawerView.frame.size.width) / _leftDrawerView.frame.size.width * 0.6f;
        
    }];
    
    
    [recognizer setTranslation:CGPointZero inView:_leftDrawerView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:_leftDrawerView];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim];
        } else{
            [self hideLeftDrawerWithAnim];
        }
    }
    
}


@end
