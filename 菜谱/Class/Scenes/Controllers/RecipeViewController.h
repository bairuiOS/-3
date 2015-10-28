//
//  RecipeViewController.h
//  菜谱
//
//  Created by lanou3g on 15/10/5.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@protocol RecipeViewControllerDelegate <NSObject>



@end

@interface RecipeViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property(nonatomic,strong)NSMutableArray *recipeArr;

@property(nonatomic,strong) UIAlertView *alert;
//传值
//先从后往前传值
@property(nonatomic,strong) NSString *str;




@end
