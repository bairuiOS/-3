//
//  RecipeStepViewCell.h
//  菜谱
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeStepViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *stepImage;

@property (weak, nonatomic) IBOutlet UILabel *stepLB;

//通过字符串计算字符串所需要的高度
+ (CGFloat)heightWithString:(NSString *)string;

@end
