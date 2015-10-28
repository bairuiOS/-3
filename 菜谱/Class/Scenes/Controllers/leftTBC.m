//
//  leftTBC.m
//  菜谱
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "leftTBC.h"
#import "DrawerViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "PendulumView.h"
#import "CollectTVC.h"

#import "DrawerCellTableViewCell.h"

static NSString *cellIdentifier = @"cellIdentifier";


@interface leftTBC ()<UIAlertViewDelegate,RecipeViewControllerDelegate>

@end

@implementation leftTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DrawerCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"drawerCell"];
    
    
    [self headView];
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"allbackground.png"]];
        [self.tableView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
        [self.tableView setBackgroundView:backImage];
    self.tableView.bounces = NO;
    
}
- (void)headView
{
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3*2, [UIScreen mainScreen].bounds.size.height * 230 / 667)];
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/5*4, [UIScreen mainScreen].bounds.size.height * 200 /667)];
    logoView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/3, ([UIScreen mainScreen].bounds.size.height * 230 / 667 + 64)/2);
    logoView.image = [UIImage imageNamed:@"title2.png"];
    [View addSubview:logoView];
    self.tableView.tableHeaderView = View;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    DrawerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drawerCell" forIndexPath:indexPath];
    //2. 判断是否有可重用的，如果没有，则自己创建
    if (indexPath.row ==0) {
        cell.titleLb.text = @"返回首页";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"homePage.png" ofType:nil];
        cell.iconView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
    }else if (indexPath.row == 1) {
        cell.titleLb.text = @"分类标签列表";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"classify.png" ofType:nil];
        cell.iconView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
    } else if (indexPath.row == 2) {
        cell.titleLb.text = @"按照ID查看菜谱";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"aboutID.png" ofType:nil];
        cell.iconView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
        
    }
    else if (indexPath.row == 3) {
        cell.titleLb.text = @"我的收藏";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"myCollect.png" ofType:nil];
        cell.iconView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
    }
    else if (indexPath.row == 4) {
        cell.titleLb.text = @"关于我们";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"aboutUs.png" ofType:nil];
        cell.iconView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
    }else if (indexPath.row == 5) {
        cell.titleLb.text = @"退出";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"exist.png" ofType:nil];
        cell.iconView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
    }
    cell.titleLb.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:234/255.0 green:160/255.0 blue:70/255.0 alpha:0.8];
    cell.layer.cornerRadius = 8;
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = [UIColor colorWithRed:234/255.0 green:160/255.0 blue:70/255.0 alpha:1].CGColor;
    cell.layer.borderWidth = 1.0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
    }

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DrawerViewController *sideViewController = [delegate sideViewController];
    
    if (indexPath.row == 0) {

        self.recipeVC.str = _textStr;
        RecipeViewController *reciVC =[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"recipe"];
        reciVC.view.backgroundColor = [UIColor whiteColor];
        reciVC.searchBar.text = _textStr;
    
    UINavigationController *recipeNAVC = [[UINavigationController alloc] initWithRootViewController:reciVC];
//        recipeNAVC.navigationBar.translucent = YES;
    sideViewController.rootViewController = recipeNAVC;
            }
    else if (indexPath.row == 1) {
        
        SortedRecipeViewController *sortVC = [delegate sortVC];
        
        UINavigationController *sortNAVC = [[UINavigationController alloc] initWithRootViewController:sortVC];
        sideViewController.rootViewController = sortNAVC;
        
    }
    else if (indexPath.row == 2) {
        
        self.searchRecipeVC.str = _textStr;
        SearchRecipeViewController *seachVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
        
        seachVC.view.backgroundColor = [UIColor whiteColor];
        
        seachVC.searchBar.text = _textStr;
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        self.searchRecipeVC =
        
        [[SearchRecipeViewController alloc] initWithCollectionViewLayout:layout];
        
        _searchRecipeVC.collectionView.backgroundColor = [UIColor whiteColor];

    _searchRecipeVC = [delegate searchVC];
    UINavigationController *searNAVC = [[UINavigationController alloc] initWithRootViewController:_searchRecipeVC];
       searNAVC.navigationBar.translucent = NO;
    sideViewController.rootViewController = searNAVC;

    }
    else if (indexPath.row == 3){
        
        CollectTVC *collect = [CollectTVC new];
        
        UINavigationController *collectNAVC = [[UINavigationController alloc] initWithRootViewController:collect];
        
        sideViewController.rootViewController = collectNAVC;
        
    }

    
    else if (indexPath.row == 4){
        
        User *user = [User new];
        
        UINavigationController *userNAVC = [[UINavigationController alloc] initWithRootViewController:user];
        
        sideViewController.rootViewController = userNAVC;
        
 
    }
    
    else if (indexPath.row == 5) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要退出" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];

    }
    
    [sideViewController hideSidetViewController:YES];
    
}

/** 退出 **/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==0){
        
        [self exitApplication];
        
    }
    
}
- (void)exitApplication {
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:2.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    //exit(0);
    
}
















-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.f;
}



    
@end
