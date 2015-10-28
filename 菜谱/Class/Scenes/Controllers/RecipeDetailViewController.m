//
//  RecipeDetailViewController.m
//  菜谱
//
//  Created by lanou3g on 15/10/5.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "URL.h"
#import "AFNetworking.h"
#import "StepViewController.h"
#import "Recipes+CoreDataProperties.h"
#import "AppDelegate.h"




@interface RecipeDetailViewController ()
@property(nonatomic,strong)StepViewController *stepVC;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollShowView;


@property(nonatomic,strong)AppDelegate *appDelegate;

@end

@implementation RecipeDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setValuesForSubViews];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    
    //初始化
    self.stepVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"step"];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:(UIBarButtonItemStyleDone) target:self action:@selector(shareAction:)];
    
    UIButton *bt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    bt.frame = CGRectMake(0, 0, 24, 24);
    [bt addTarget:self action:@selector(collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setBackgroundImage:[UIImage imageNamed:@"shares.png"] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bt];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"收藏.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(collectAction:)];
    
    
    self.appDelegate = [UIApplication sharedApplication].delegate;
    
 }



//收藏
-(void)collectAction:(UIButton *)share{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@", _recipe.title];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
//                                                                   ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"%@",error);
    }
    if (fetchedObjects.count!=0) {
       
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 120)/2, ([UIScreen mainScreen].bounds.size.height - 100)/2 , 120, 45)];
        label.text =@"已经收藏过";
        label.textColor = [UIColor whiteColor];
//        label.textColor = [UIColor redColor];
        label.alpha=0;
       label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        [UIView animateWithDuration:1  animations:^{
            label.alpha=0.9;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 delay:1 options:(UIViewAnimationOptionShowHideTransitionViews) animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
        
        return;
    }
    
    else{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 120)/2, ([UIScreen mainScreen].bounds.size.height - 100)/2 , 120, 45)];
        label.text =@"收藏成功";
        label.textColor = [UIColor whiteColor];
        label.alpha=0;
        label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        [UIView animateWithDuration:0.6  animations:^{
            label.alpha=0.7;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 delay:0.6 options:(UIViewAnimationOptionShowHideTransitionViews) animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];

        
    }
    
    //创建实体描述
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    //创建数据模型
    Recipes *recipes = [[Recipes alloc] initWithEntity:description insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    
    recipes.title = _recipe.title;
    
    //归档
    recipes.albums = [NSKeyedArchiver archivedDataWithRootObject:_recipe.albums];
    recipes.steps = [NSKeyedArchiver archivedDataWithRootObject:_recipe.steps];
    
//  recipes.number = @"1";
    
   // recipes.idcid = _recipe.idcid;
    
//  recipes.idcid = @1;///传值不行
    //recipes.idcid = _recipe.idcid;
    
    recipes.tags = _recipe.tags;
    
    recipes.imtro = _recipe.imtro;
    
    recipes.ingredients = _recipe.ingredients;
    
    recipes.burden = _recipe.burden;
    
    recipes.img = _recipe.img;
    
    recipes.step = _recipe.step;
    
    
    //保存
    [self.appDelegate saveContext];
    

    
}







//控件赋值
-(void)setValuesForSubViews{
    
    self.titleName.text = _recipe.title;
    
    self.ingredients.text = _recipe.ingredients;
    
    self.burden.text = _recipe.burden;
    
    self.intro.text = _recipe.imtro;
    
    self.tags.text = _recipe.tags;
    
}

//点击具体步骤

- (IBAction)stepBT:(id)sender {
    
    
    _stepVC.recipe =_recipe;
    
    [self.navigationController pushViewController:_stepVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
