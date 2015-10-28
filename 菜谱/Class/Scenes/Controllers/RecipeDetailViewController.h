//
//  RecipeDetailViewController.h
//  菜谱
//
//  Created by lanou3g on 15/10/5.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
@interface RecipeDetailViewController : UIViewController
//菜名
@property (weak, nonatomic) IBOutlet UILabel *titleName;
//食材
@property (weak, nonatomic) IBOutlet UILabel *ingredients;
//佐料
@property (weak, nonatomic) IBOutlet UILabel *burden;
//介绍
@property (weak, nonatomic) IBOutlet UILabel *intro;
//标签
@property (weak, nonatomic) IBOutlet UILabel *tags;

@property(nonatomic,strong) Recipe *recipe;
@property(nonatomic,strong) NSMutableArray *recipeArr;




@end
