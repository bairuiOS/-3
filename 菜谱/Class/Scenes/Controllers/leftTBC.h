//
//  leftTBC.h
//  菜谱
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeViewController.h"
#import "SortedRecipeViewController.h"
#import "SearchRecipeViewController.h"
@interface leftTBC : UITableViewController

//接收上个界面传过来的字符串
@property(nonatomic,strong) NSString *textStr;



@property(nonatomic,strong) RecipeViewController *recipeVC;
@property(nonatomic,strong) SearchRecipeViewController *searchRecipeVC;


@end
