//
//  UIViewController+Transition.h
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/20.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(Transition)

- (void)transitionFromViewController:( UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration;

- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration animations:(void (^ __nullable)(void))animations;

@end
