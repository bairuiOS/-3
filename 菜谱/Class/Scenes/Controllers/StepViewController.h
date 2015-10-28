//
//  StepViewController.h
//  菜谱
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface StepViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) Recipe *recipe;
@property(nonatomic,strong) NSMutableArray *recipeArr;





@end
