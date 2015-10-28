//
//  RecipeViewCell.h
//  菜谱
//
//  Created by lanou3g on 15/10/5.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;

@property (weak, nonatomic) IBOutlet UILabel *recipeName;

@property (weak, nonatomic) IBOutlet UIImageView *tinyImage;

@end
