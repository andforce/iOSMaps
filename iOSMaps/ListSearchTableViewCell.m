//
//  ListSearchTableViewCell.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/26.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "ListSearchTableViewCell.h"
#import "SearchView.h"

@implementation ListSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void) layoutSubviews {
//    [super layoutSubviews];
//    self.frame = CGRectMake(9, 44, 302, 44);
//    self.backgroundView.frame = CGRectMake(0, 44, 302, 44);
//    self.selectedBackgroundView.frame = CGRectMake(0, 44, 302, 44);
//}

-(void)setFrame:(CGRect)frame{
    frame.origin.x += kViewHeight / 4.0f;
    
    frame.size.width -= 2 * kViewHeight / 4.0f;
    
    [super setFrame:frame];
}



@end
