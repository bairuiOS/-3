//
//  SearchRecipeViewController.h
//  菜谱
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface SearchRecipeViewController : UICollectionViewController


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property(nonatomic,strong) NSMutableArray *searchArr;
@property(nonatomic,strong) UIAlertView *alert;

//传值
@property(nonatomic,strong) NSString *str;

@end
