//
//  UIViewController+Transition.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/20.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "UIViewController+Transition.h"


@implementation UIViewController(Transition)

-(void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController{
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
        //
    } completion:^(BOOL finished) {
        //
    }];
}

-(void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration{
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:duration options:UIViewAnimationOptionTransitionNone animations:^{
        //
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration animations:(void (^ __nullable)(void))animations{
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:duration options:UIViewAnimationOptionTransitionNone animations:animations completion:nil];
}

@end
