//
//  SortCollectionViewController.m
//  菜谱
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "SortCollectionViewController.h"

#import "URL.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"

#import "AFNetworking.h"

#import "SortCollectionCell.h"
#import "Sort.h"
#import "SortDetailCollection.h"



@interface SortCollectionViewController ()

@property(nonatomic,strong)SortDetailCollection *sortDetailVC;

@end

@implementation SortCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"SortCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-daohangliebiao@2x.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.title = @"分类列表";
    
    //设置背景图片
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"allbackground.png"]];
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]];
    [self.collectionView setBackgroundView:backImage];

    
    
    //请求数据
    [self updateSortRecipe];
    //刷新数据
    [self.collectionView reloadData];
    
    //布局navigationItem
    [self customizeNavigation];
    
}
//布局navigation
-(void)customizeNavigation{
    
    
    UIButton *bt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    bt.frame = CGRectMake(0, 0, 26, 26);
    [bt addTarget:self action:@selector(rigthAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setBackgroundImage:[UIImage imageNamed:@"btn_nav_list@2x.png"] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bt];
    

    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_list@2x.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(rigthAction:)];
    
}

-(void)rigthAction:(UIBarButtonItem *)right{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
        [self.collectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _sortArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SortCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
   //赋值
    //获取对应的sort
    Sort *sort = _sortArr[indexPath.row];
    
    //分类名赋值
    cell.recipeName.text = sort.name;
    cell.recipeName.textColor = [UIColor whiteColor];
//    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
//    
//    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
//    
//    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
//    cell.backgroundColor= [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.35];
//    
    cell.backgroundColor = [UIColor colorWithRed:234/255.0 green:160/255.0 blue:70/255.0 alpha:0.5];
    
      
   
    
    //切圆
    cell.layer.cornerRadius = cell.frame.size.height / 10 + cell.frame.size.height / 9;

    
    return cell;
}

//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.sortDetailVC =
    
    [[SortDetailCollection alloc] initWithCollectionViewLayout:layout];
    
    _sortDetailVC.collectionView.backgroundColor = [UIColor whiteColor];
    
    //_sortDetailVC.navigationItem.hidesBackButton = YES;
    
    self.sortDetailVC.sort = _sortArr[indexPath.row];
    
    [self.navigationController pushViewController:_sortDetailVC animated:YES];
    
}



//边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

//cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row %2 == 0) {
//        
//        return CGSizeMake(80, 80);
//    }
//    
//    return CGSizeMake(110, 110);
//
//    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-55 )/3,([UIScreen mainScreen].bounds.size.width-55)/3);
    
        //if (indexPath.row %2 != 0) {
    
            return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 50)/3, ([UIScreen mainScreen].bounds.size.width - 50 )/3);
        //}
    
        //return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 75)/3, ([UIScreen mainScreen].bounds.size.width - 75)/3);

    
}
//item的左右边距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 15;
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
