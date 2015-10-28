//
//  RecipeViewController.m
//  菜谱
//
//  Created by lanou3g on 15/10/5.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeViewCell.h"
#import "Recipe.h"
#import "RecipeDetailViewController.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "leftTBC.h"

#import "URL.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "PendulumView.h"

@interface RecipeViewController ()<UISearchBarDelegate>

@property(nonatomic,strong)RecipeDetailViewController *recipeVC;

@property(nonatomic,strong)UITextField *tf;

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation 上title的颜色
    UIColor * color = [UIColor lightGrayColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    //设置navigationbar  的颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.searchBar.delegate = self;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RecipeViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RecipeCell"];
    
    
    //searchBar 输入文字的颜色
//    / Get the instance of the UITextField of the search bar
    UITextField *searchField = [self.searchBar valueForKey:@"_searchField"];
    
    // Change search bar text color
    searchField.textColor = [UIColor whiteColor];
    
    // Change the search bar placeholder text color  
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    

    
    
    //左边bar的颜色
    UIButton *bt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    bt.frame = CGRectMake(0, 0, 30, 30);
    [bt addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setBackgroundImage:[UIImage imageNamed:@"iconfont-daohangliebiao.png"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bt];
    

    
    //设置title的颜色

   
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-daohangliebiao.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //刷新数据
    [self.tableView reloadData];
    
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }

    [header setImages:idleImages forState:MJRefreshStateIdle];
    

    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.tableView.header = header;
    

    
}

//////下拉刷新数据
-(void)loadNewData{
    

    
    if (_searchBar.text.length != 0) {
        [self updateRecipe:_searchBar.text];
    }
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.header endRefreshing];
    
    [self.tableView reloadData];
    

}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.str = _searchBar.text;
    

    if (![_searchBar.text isEqualToString:@""]) {
        
        [self updateRecipe:_searchBar.text];
        
    }else{
        //默认
        [self updateRecipe:@"土豆"];
    }
    
}
//左抽屉
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DrawerViewController *sideViewController = [delegate sideViewController];
    [sideViewController showLeftViewController:true];
}

//请求数据
- (void)updateRecipe:(NSString *)menu
{
    ///////////////
    UIColor *ballColor = [UIColor colorWithRed:0.47 green:0.60 blue:0.89 alpha:1];
    PendulumView *pendulum = [[PendulumView alloc] initWithFrame:self.view.bounds ballColor:ballColor];
    [self.view addSubview:pendulum];

    
    //请求数据
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:kKey forKey:@"key"];
    [params setValue:menu forKey:@"menu"];
    
     
    [mgr GET:kRecipeURL parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        
        
        if (!_recipeArr) {
            self.recipeArr = [NSMutableArray array];

        }
        
        //移除
        [_recipeArr removeAllObjects];
        if ([[responseObject valueForKey:@"error_code"] intValue] == 0) {
            
            NSDictionary *dataDic = [responseObject valueForKey:@"result"];
            
            NSMutableArray *dataArr = [dataDic valueForKey:@"data"];
            
            for (NSDictionary *dic in dataArr) {
                
                
                
                Recipe *recipe = [Recipe new];
                
                //通过KVC赋值
                [recipe setValuesForKeysWithDictionary:dic];
                
                
                //装入数组
                
                [_recipeArr addObject:recipe];
                //NSLog(@"%@",recipe.steps);
                
            }
            
            //NSLog(@"%@",_recipeArr);
            
            //刷新数据
            [self.tableView reloadData];
            
            
            [pendulum removeFromSuperview];
            
        }else{
            NSLog(@"%@",[responseObject valueForKey:@"reason"]);
            
            NSString *reason= [responseObject valueForKey:@"reason"];
            
        self.alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:reason delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [_alert show];
                [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        return;
        
        }
    
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
    

- (IBAction)changeRecipe:(id)sender {
    
    
    if (_searchBar.text.length != 0) {
        [self updateRecipe:_searchBar.text];
    }
    
    [self.view endEditing:YES];
    
    [self.tableView.header beginRefreshing];
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

    return _recipeArr.count;
}

//生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    
    //赋值
    //获取对应的recipe
    
    Recipe *recipe = _recipeArr[indexPath.row];
    
    //菜名赋值
    cell.recipeName.text = recipe.title;
    
    //图片赋值
    [cell.recipeImage sd_setImageWithURL:[NSURL URLWithString:recipe.albums[0]] placeholderImage:[UIImage imageNamed:@"18.png"]];
    [cell.tinyImage sd_setImageWithURL:[NSURL URLWithString:recipe.albums[0]] placeholderImage:[UIImage imageNamed:@"18.png"]];
    cell.tinyImage.layer.cornerRadius = 30;
    cell.tinyImage.layer.masksToBounds = YES;
    cell.tinyImage.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.tinyImage.layer.borderWidth = 2;

    
    
    //改变cell 的透明度
    cell.opaque = NO;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
    
    
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UIScreen mainScreen].bounds.size.height/3;
}

//点击cell

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    //传值
    //初始化
    self.recipeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RecipeDetail"];
    self.recipeVC.recipe = _recipeArr[indexPath.row];
    NSLog(@"%@",_recipeVC.recipe);
    [self.navigationController pushViewController:_recipeVC animated:YES];
    
    
}
//点击return回收键盘
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar

{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//TODO: button也要赋值
    appDelegate.leftTbc.textStr = searchBar.text;
    [self.view endEditing:YES];
    [self.tableView.header beginRefreshing];
    
}


//自动消失
-(void)performDismiss:(NSTimer *)alert{
    
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
    
}



#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
*/

@end
