//
//  RecipeStepViewCell.m
//  菜谱
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "RecipeStepViewCell.h"

@implementation RecipeStepViewCell

//通过字符串计算字符串所需要的高度
+ (CGFloat)heightWithString:(NSString *)string{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(200, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:17]} context:nil];
    
    return rect.size.height;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
