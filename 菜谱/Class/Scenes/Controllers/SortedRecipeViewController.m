//
//  SortedRecipeViewController.m
//  菜谱
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "SortedRecipeViewController.h"


#import "URL.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"

#import "AFNetworking.h"

#import "SortCell.h"
#import "Sort.h"

#import "SortCollectionViewController.h"
#import "SortDetailCollection.h"

@interface SortedRecipeViewController ()
@property(nonatomic,strong)SortDetailCollection *sortDetailVC;

@end

@implementation SortedRecipeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SortCell" bundle:nil] forCellReuseIdentifier:@"sortCell"];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-daohangliebiao.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //设置背景图片
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"allbackground.png"]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
    [self.tableView setBackgroundView:backImage];
    
    //设置navigationbar  的颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //设置title的颜色
    
    
    //请求数据
    [self updateSortRecipe];
    //刷新数据
    [self.tableView reloadData];
    
    //布局navigationItem
    [self customizeNavigation];
    
    
}
//布局navigation
-(void)customizeNavigation{
    
    
    UIButton *bt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    bt.frame = CGRectMake(0, 0, 26, 26);
    [bt addTarget:self action:@selector(rigthAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setBackgroundImage:[UIImage imageNamed:@"btn_nav_collection@2x.png"] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bt];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_collection@2x.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(rigthAction:)];
    
}
//rightAction 进入视图控制器列表
-(void)rigthAction:(UIBarButtonItem *)rigthBI{
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    SortCollectionViewController *sortCollectionVC =
    
     [[SortCollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    sortCollectionVC.collectionView.backgroundColor = [UIColor whiteColor];
    
    sortCollectionVC.navigationItem.hidesBackButton = YES;
    
    [self.navigationController pushViewController:sortCollectionVC animated:YES];

}

//左抽屉
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DrawerViewController *sideViewController = [delegate sideViewController];
    [sideViewController showLeftViewController:true];
}
//请求数据
-(void)updateSortRecipe{
    [self.sortArr removeAllObjects];
    self.sortArr = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:kKey forKey:@"key"];
    
    [mgr GET:kSortedRecipeURL parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
       // NSLog(@"%@",responseObject);
        
        NSMutableArray *dataArr = [responseObject valueForKey:@"result"];
        
        for (NSDictionary *dataDic in dataArr) {
            
            Sort *sort = [Sort new];
            
            //通过KVC赋值
            [sort setValuesForKeysWithDictionary:dataDic];
            
           // NSLog(@"%@",sort);
            
            //装入数组
            [_sortArr addObject:sort];
            
            //NSLog(@"%@",_sortArr);
        }
        
        //刷新数据
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
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

    return _sortArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sortCell" forIndexPath:indexPath];
    //赋值
    //获取对应的sort
    Sort *sort = _sortArr[indexPath.row];
    
    //分类名赋值
    cell.recipeName.text = sort.name;
    
    //改变cell 的透明度
    cell.opaque = NO;
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];

    
    return cell;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}
//点击 cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.sortDetailVC =
    
    [[SortDetailCollection alloc] initWithCollectionViewLayout:layout];
    
    _sortDetailVC.collectionView.backgroundColor = [UIColor whiteColor];
    
    //_sortDetailVC.navigationItem.hidesBackButton = YES;
    
    self.sortDetailVC.sort = _sortArr[indexPath.row];
    
    [self.navigationController pushViewController:_sortDetailVC animated:YES];
    
    
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
