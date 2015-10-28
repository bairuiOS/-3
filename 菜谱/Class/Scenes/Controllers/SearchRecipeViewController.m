//
//  SearchRecipeViewController.m
//  菜谱
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "SearchRecipeViewController.h"
#import "SearchCollectionCell.h"
#import "Search.h"
#import "RecipeDetailViewController.h"


#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "leftTBC.h"

#import "URL.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"

#import "PendulumView.h"


@interface SearchRecipeViewController ()

@property(nonatomic,strong)RecipeDetailViewController *recipeVC;
@property(nonatomic,strong)UITextField *tf;         
@property (weak, nonatomic) IBOutlet UIView *bzdView;

@end


@interface SearchRecipeViewController ()<UISearchBarDelegate>

@end

@implementation SearchRecipeViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    //设置navigationbar  的颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //设置title的颜色
    UIColor * color = [UIColor lightGrayColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    

    
    
    //初始化
    self.recipeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RecipeDetail"];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-daohangliebiao.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
   //刷新数据
    [self.collectionView reloadData];
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
    //    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.collectionView.header = header;

//    //设置背景图片
//    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"022.jpg"]];
//    [self.collectionView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
//    [self.collectionView setBackgroundView:backImage];

    
    
}

-(void)loadNewData{
    NSString *randomId = [NSString stringWithFormat:@"%u",arc4random()%100];
    
    [self updateRecipe:randomId];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.collectionView.header endRefreshing];
    
    [self.collectionView reloadData];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.str = _searchBar.text;
    
    if (![_searchBar.text isEqualToString:@""]) {
        
        [self updateRecipe:_searchBar.text];
    }else{
        
        //默认 cid = 3
        [self updateRecipe:@"3"];
    }
    
}

//左抽屉
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DrawerViewController *sideViewController = [delegate sideViewController];
    [sideViewController showLeftViewController:true];
}
- (IBAction)searchID:(id)sender {
 
    
    if (_searchBar.text.length != 0) {
        
        [self updateRecipe:_searchBar.text];

    }
    [self.view endEditing:YES];
    
    [self.collectionView.header beginRefreshing];

    
}



//请求数据
-(void)updateRecipe:(NSString *)cid{

    
    self.searchArr = [NSMutableArray array];
    
    //请求数据
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:kKey forKey:@"key"];
    
    [params setValue:cid forKey:@"cid"];
    
    [mgr GET:kSearchRecipeURL parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    
        
        if ([[responseObject valueForKey:@"error_code"] intValue] == 0 ) {
            
            
    ///////////////
    UIColor *ballColor = [UIColor colorWithRed:0.47 green:0.60 blue:0.89 alpha:1];
    PendulumView *pendulum = [[PendulumView alloc] initWithFrame:self.view.bounds ballColor:ballColor];
    [self.view addSubview:pendulum];
            
        
    NSDictionary *dataDic = [responseObject valueForKey:@"result"];
        
    NSMutableArray *dataArr = [dataDic valueForKey:@"data"];
        
        for (NSDictionary *dic in dataArr) {
            
            Search *search = [Search new];
            
            //通过KVC赋值
            [search setValuesForKeysWithDictionary:dic];
            
            //装入数组
            [_searchArr addObject:search];
            
           // NSLog(@"%@",_searchArr);
            
        }
        
        //刷新数据
        [self.collectionView reloadData];
        [self.collectionView bringSubviewToFront:self.bzdView];
            
            
            //请求完数据就移除
            
            [pendulum removeFromSuperview];
        
        }else{
            
            NSString *reason= [responseObject valueForKey:@"reason"];
            
            self.alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:reason delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [_alert show];
            //自动消失
            [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            return;
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}

//自动消失
-(void)performDismiss:(NSTimer *)alert{
    
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _searchArr.count;
}

//生成cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //赋值
    //获取对应的search
    Search *search = _searchArr[indexPath.row];
    
    //菜名赋值
    cell.searchName.text = search.title;
    
    //图片赋值
    [cell.searchImage sd_setImageWithURL:[NSURL URLWithString:search.albums[0]] placeholderImage:[UIImage imageNamed:@"18.png"]];

    
    //设置cell的背景
    cell.opaque = NO;
    
    cell.backgroundColor = [UIColor clearColor];
    // cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.5f];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.collectionView.bounds];
    imageView.image = [UIImage imageNamed:@"allbackground.png"];

    cell.backgroundView = imageView;
    
    
    return cell;
}
//点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //传值
    _recipeVC.recipe = _searchArr[indexPath.row];
    
    [self.navigationController pushViewController:_recipeVC animated:YES];
    
}


//边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(40, 5, 10, 10);
    
}

//cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width -36)/3,([UIScreen mainScreen].bounds.size.height - 60 ) /3);

    
}
//item的左右边距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 8;
    
}

//点击return 回收键盘
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar

{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //TODO: button也要赋值
    appDelegate.leftTbc.textStr = searchBar.text;
    [self.view endEditing:YES];
    [self searchID:nil];
    
    [self.collectionView.header beginRefreshing];


}





@end
