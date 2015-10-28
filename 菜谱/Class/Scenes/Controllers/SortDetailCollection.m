//
//  SortDetailCollection.m
//  菜谱
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "SortDetailCollection.h"
#import "AFNetworking.h"
#import "URL.h"
#import "SortDetail.h"
#import "SortDetailCollectionCell.h"



@interface SortDetailCollection ()

@end

@implementation SortDetailCollection

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"SortDetailCollectionCell" bundle:nil]  forCellWithReuseIdentifier:reuseIdentifier];
    
    self.title = @"列表详情";
    
    //设置背景图片
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"allbackground.png"]];
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]];
    [self.collectionView setBackgroundView:backImage];
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _sort.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SortDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    SortDetail *sortDetail = _sort.list[indexPath.row];
    
    //分类赋值
    cell.sortName.text = sortDetail.name;
    cell.sortName.textColor= [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor colorWithRed:177/255.0 green:125/255.0 blue:64/255.0 alpha:0.8];
   
    
    cell.layer.cornerRadius = cell.frame.size.height / 2;
    
    return cell;
}

////点击cell
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.haodou.com/recipe/all"]];
//    
//    [webView loadRequest:request];
//    
//    //自适应屏幕
//    webView.scalesPageToFit = YES;
//    
//    [self.view addSubview:webView];
//    
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    /** 你要去除的标签 **/
//    [webView stringByEvaluatingJavaScriptFromString:@""];
//}



//边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

//cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    //if (indexPath.row %2 != 0) {
//        
//        return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 50)/3, ([UIScreen mainScreen].bounds.size.width - 50 )/3);
//    //}
//    
//    //return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 75)/3, ([UIScreen mainScreen].bounds.size.width - 75)/3);
    
     return CGSizeMake(([UIScreen mainScreen].bounds.size.width-55 )/3,([UIScreen mainScreen].bounds.size.width-55)/3);
    
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
