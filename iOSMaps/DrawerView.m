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
    UIButton *_drawerMaskView;
    
    
    UIView *_rightDrawerView;
    UIView *_rightEageView;
}

@end


@implementation DrawerView

-(id)init{
    if (self == [super init]) {
        
        [self setDrawerType:DrawerViewTypeLeft];
        
        [self initLeftDrawer];
        
        [self initMaskView];
        
        UIScreenEdgePanGestureRecognizer *edgePab = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handlerEdgePan:)];
        edgePab.edges = UIRectEdgeLeft;
        
        [self addGestureRecognizer:edgePab];
        
        [self setEnadbled:YES];

    }
    return self;
}


-(id)initWithDrawerType:(DrawerViewType)drawerType{
   
    if (self == [super init]) {
        [self setDrawerType:drawerType];
        
        switch (_drawerType) {
            case DrawerViewTypeLeft:{
                [self initLeftDrawer];
                break;
            }
            case DrawerViewTypeRight:{
                [self initRightDrawer];
                break;
            }
            case DrawerViewTypeLeftAnd:{
                [self initLeftDrawer];
                [self initRightDrawer];
                break;
            }
                
            default:{
                [self initLeftDrawer];
                break;
            }
        }
        
        [self initMaskView];
        
        [self setEnadbled:YES];
    }

    
    return self;
}


-(void)didAddSubview:(UIView *)subview{
    NSLog(@"didAddSubview");
}

-(void)didMoveToSuperview{
    
    UIView *rootView = [self superview];
    
    self.frame = CGRectMake(0, 0, kEdge, rootView.frame.size.height);
    
    NSLog(@"didMoveToSuperview %f", rootView.frame.size.width);
    

    _drawerMaskView.frame = CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height);

    [rootView addSubview:_drawerMaskView];
    
    
    
    if (_drawerType != DrawerViewTypeLeft) {
        _rightEageView = [[UIView alloc]init];
        _rightEageView.frame = CGRectMake(rootView.frame.size.width - kEdge, 0, kEdge, rootView.frame.size.height);
        _rightEageView.backgroundColor = [UIColor redColor];
        
        [rootView addSubview:_rightEageView];
        
        UIScreenEdgePanGestureRecognizer *rightedgePab = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handlerRightEdgePan:)];
        rightedgePab.edges = UIRectEdgeRight;
        
        [_rightEageView addGestureRecognizer:rightedgePab];
    }
    
    
    CGFloat with = rootView.frame.size.width * kDefaultDrawerRatio;
    
    
    if (_drawerType != DrawerViewTypeRight) {
        // init Left Drawer
        _leftDrawerView.frame = CGRectMake(- with, 0, with, rootView.frame.size.height);
        [rootView addSubview:_leftDrawerView];
    }

    if (_drawerType != DrawerViewTypeLeft) {
        // init right Drawer
        _rightDrawerView.frame = CGRectMake(rootView.frame.size.width, 0, with, rootView.frame.size.height);
        [rootView addSubview:_rightDrawerView];
    }
    

}




- (void) showLeftDrawerWithAdim:(UIView *)view{
    
    [self setOpened:true];
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect currentRect = view.frame;
        currentRect.origin.x = 0;
        view.frame = currentRect;
        
        view.alpha =  kMaxMaskAlpha;
        
        view.layer.shadowOpacity = 0.5f;
    } completion:^(BOOL finished) {
        if (_delegate != nil) {
            [_delegate drawerDidOpened];
        }
        [self setOpened:finished];
    }];

}


-(void) hideLeftDrawerWithAnim:(UIView *)view{
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect currentRect = view.frame;
        currentRect.origin.x = -view.frame.size.width;
        view.frame = currentRect;
        
        view.layer.shadowOpacity = 0.f;
        
        _drawerMaskView.alpha =  0.0f;
    } completion:^(BOOL finished) {
        if (_delegate != nil) {
            [_delegate drawerDidClosed];
        }
        [self setOpened:!finished];
    }];
}


-(void) initRightDrawer{
    _rightDrawerView = [[UIView alloc]init];
    
    
    _rightDrawerView.backgroundColor = [UIColor whiteColor];
    
    _rightDrawerView.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    _rightDrawerView.layer.shadowOpacity = 0.f;
    //设置View Shadow的偏移量
    _rightDrawerView.layer.shadowOffset = CGSizeMake(-5.f, 0);
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleRightPan:)];
    [_rightDrawerView addGestureRecognizer:panGestureRecognizer];
}

-(void) initLeftDrawer{

    _leftDrawerView = [[UIView alloc]init];
    

    _leftDrawerView.backgroundColor = [UIColor whiteColor];
    
    _leftDrawerView.layer.shadowColor = [[UIColor blackColor]CGColor];
    // 阴影的透明度
    _leftDrawerView.layer.shadowOpacity = 0.f;
    //设置View Shadow的偏移量
    _leftDrawerView.layer.shadowOffset = CGSizeMake(5.f, 0);
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleLeftPan:)];
    [_leftDrawerView addGestureRecognizer:panGestureRecognizer];
    
}

-(void) initMaskView{
    _drawerMaskView = [[UIButton alloc]init];
    _drawerMaskView.backgroundColor = [UIColor blackColor];
    _drawerMaskView.alpha = 0.0f;
    
    [_drawerMaskView addTarget:self action:@selector(hideLeftDrawerWithAnim:) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *maskPan = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(handleMaskPan:)];
    [_drawerMaskView addGestureRecognizer:maskPan];
    
}



-(void) showOrHideAfterPan: (UIPanGestureRecognizer*) recognizer :(UIView *)view{
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim: view];
        } else{
            [self hideLeftDrawerWithAnim:view];
        }
    }
}

-(void) handlerEdgePan:(UIScreenEdgePanGestureRecognizer *) recognizer{
    if (![self enadbled]) {
        return;
    }
    [self handleLeftPan:recognizer];
}

-(void)handlerRightEdgePan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    if (![self enadbled]) {
        return;
    }
    [self handleRightPan:recognizer];
}


- (void) handleMaskPan:(UIPanGestureRecognizer*) recognizer{
    if (![self enadbled]) {
        return;
    }
    
    [self dragLeftDrawer:recognizer :^CGFloat(CGFloat x, CGFloat maxX) {
       return  x < maxX ? x : maxX;
    }];

    
}

- (void) handleLeftPan:(UIPanGestureRecognizer*) recognizer{
    
    if (![self enadbled]) {
        return;
    }
    
    [self dragLeftDrawer:recognizer :^CGFloat(CGFloat x, CGFloat maxX) {
        return x > maxX ? maxX : x;
    }];
}

- (void) handleRightPan:(UIPanGestureRecognizer*) recognizer{
    
    if (![self enadbled]) {
        return;
    }
    
    [self dragRightDrawer:recognizer :^CGFloat(CGFloat x, CGFloat maxX) {
        return x < maxX ? maxX : x;
    }];
}


-(void) showOrHideRightAfterPan: (UIPanGestureRecognizer*) recognizer :(UIView *)view{
    [recognizer setTranslation:CGPointZero inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self];
        
        NSLog(@"Touch ===   %f", velocity.x);
        
        if (velocity.x > 0) {
            [self showLeftDrawerWithAdim: view];
        } else{
            [self hideLeftDrawerWithAnim: view];
        }
    }
}

-(void) dragRightDrawer:(UIPanGestureRecognizer *)recognizer :(TouchX) block{
    UIView * panView = [recognizer.view superview];
    
    CGPoint translation = [recognizer translationInView:panView];
    
    CGPoint currentCenter = _rightDrawerView.center;
    
    
    CGFloat x = currentCenter.x + translation.x;
    
    CGFloat maxX = panView.frame.size.width - _rightDrawerView.frame.size.width / 2 ;
    
    currentCenter.x = block(x, maxX);

    NSLog(@"dragRightDrawer %f             %f " , currentCenter.x, translation.x);
    
    _rightDrawerView.center = currentCenter;
    

    
    if (translation.x < 0 ) {
        _rightDrawerView.layer.shadowOpacity = 0.5f;
    }
    
    _drawerMaskView.alpha = (panView.frame.size.width - _rightDrawerView.center.x ) / _rightDrawerView.frame.size.width / 2 * kMaxMaskAlpha;
    
    [recognizer setTranslation:CGPointMake(panView.frame.size.width, 0) inView:panView];
    
    [self showOrHideRightAfterPan:recognizer :_rightDrawerView];
}

-(void) dragLeftDrawer:( UIPanGestureRecognizer *)recognizer : (TouchX) block{
    
    UIView * panView = [recognizer.view superview];
    
    CGPoint translation = [recognizer translationInView:panView];
    
    
    CGPoint currentCenter = _leftDrawerView.center;

    
    NSLog(@"dragLeftDrawer %f             %f " , currentCenter.x, translation.x);
    
    
    CGFloat x = currentCenter.x + translation.x;
    
    CGFloat maxX = _leftDrawerView.frame.size.width / 2;
    
    //currentCenter.x = x < maxX ? x : maxX;
    currentCenter.x = block(x, maxX);
    
    _leftDrawerView.center = currentCenter;
    
    if (translation.x > 0 ) {
        _leftDrawerView.layer.shadowOpacity = 0.5f;
    }
    
    _drawerMaskView.alpha = (_leftDrawerView.center.x + maxX ) / (maxX * 2) * kMaxMaskAlpha;
    
    [recognizer setTranslation:CGPointZero inView:panView];
    
    [self showOrHideAfterPan:recognizer :_leftDrawerView];
    
}

@end
