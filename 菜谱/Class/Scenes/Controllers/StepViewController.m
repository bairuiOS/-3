//
//  StepViewController.m
//  菜谱
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "StepViewController.h"
#import "RecipeStepViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "URL.h"
#import "StepModel.h"


@interface StepViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    CGRect frame_first;
    
    UIImageView *fullImageView;
    
}

@property(nonatomic,strong)UIView *selectedBackgroundView;

@end

@implementation StepViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"RecipeStepViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"recipeStepCell"];
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"allbackground.png"]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
    [self.tableView setBackgroundView:backImage];
    
    
    //分享
//    UIButton *bt = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    bt.frame = CGRectMake(0, 0, 24, 24);
//    [bt addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [bt setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:(UIControlStateNormal)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bt];
    
}
//-(void)shareAction:(UIButton *)share{
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"507fcab25270157b37000010"
//                                      shareText:@"请输入你想分享的文字......"
//                                     shareImage:[UIImage imageNamed:@"icon.png"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban,nil]
//                                       delegate:self];
//    
//    
//}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.tableView reloadData];

    //点击时间 返回顶部
    
//    //CGRectMake(0, 0, 1, 1)可以直接返回到UITableView的最顶端
//    
//    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
//    
//    //CGRectMake(0, 0, 0, 0)设定无效
//    
//    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 0, 0) animated:NO];

    self.tableView.scrollsToTop = YES;
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

    return _recipe.steps.count;
    
    
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeStepViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeStepCell" forIndexPath:indexPath];
    
    StepModel *step = _recipe.steps[indexPath.row];
    
    //步骤赋值
    cell.stepLB.text = step.step;
    
    //步骤图片
    [cell.stepImage sd_setImageWithURL:[NSURL URLWithString:step.img] placeholderImage:[UIImage imageNamed:@"18.png"]];
    
    cell.stepImage.tag = 9999;
    //打开用户交互
    cell.stepImage.userInteractionEnabled = YES;
    
    [cell.stepImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
    [cell.contentView addSubview:cell.stepImage];
    
    //改变cell 的透明度
    cell.opaque = NO;
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];

    return cell;
}

-(void)actionTap:(UITapGestureRecognizer *)sender{
    
    
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath  = [self.tableView indexPathForRowAtPoint:location];
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView  cellForRowAtIndexPath:indexPath];
    
    UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:9999];
    
    frame_first=CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-self.tableView.contentOffset.y, imageView.frame.size.width, imageView.frame.size.height);

    fullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    fullImageView.backgroundColor=[UIColor blackColor];
    fullImageView.userInteractionEnabled=YES;
    [fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap2:)]];
    fullImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    if (![fullImageView superview]) {
        
        fullImageView.image=imageView.image;
        
        [self.view.window addSubview:fullImageView];
        
        
        
        fullImageView.frame=frame_first;
        [UIView animateWithDuration:0.5 animations:^{
            
            fullImageView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            
        } completion:^(BOOL finished) {
            
            [UIApplication sharedApplication].statusBarHidden=YES;
            
        }];
    }
    
}

-(void)actionTap2:(UITapGestureRecognizer *)sender{
    
 
    [UIView animateWithDuration:0.5 animations:^{
        
        fullImageView.frame=frame_first;
        
        
    } completion:^(BOOL finished) {
        
        [fullImageView removeFromSuperview];
        
        
    }];
    
    
    [UIApplication sharedApplication].statusBarHidden=NO;
    
}

//给cell 添加背景图片
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    cell.textLabel.backgroundColor = [UIColor clearColor];
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取对应的model类
    StepModel *step = _recipe.steps[indexPath.row];
    
    //计算描述地址所需要的高度
    CGFloat height = [RecipeStepViewCell heightWithString:step.step];
    if (height < 120) {
        
        return 120;
    }
    
    return height - 10;
    
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
