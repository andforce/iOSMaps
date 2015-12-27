//
//  SearchTableViewCell.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/26.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "GrideSearchTableViewCell.h"
#import "CommonUtils.h"

@implementation GrideSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    
    CGFloat gaps = (width - 8 * 2 - height * 5) / 5.f;
    
    NSArray * views = self.subviews.firstObject.subviews;
    
    NSUInteger count = views.count;
    for (int i = 0; i < count; i++) {
        UIButton * view = views [i];
        CGRect currentFrame = view.frame;
        currentFrame.origin.x = 8 + gaps * i + CGRectGetHeight(currentFrame) * i;
        view.frame = currentFrame;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
