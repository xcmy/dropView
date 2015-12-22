//
//  ViewController.m
//  dropView
//
//  Created by 刘洋 on 15/12/17.
//  Copyright © 2015年 刘洋. All rights reserved.
//

#import "ViewController.h"
#import "JDDropView.h"

@interface ViewController ()<DropViewDataSource,DropViewDelegate>

@property(nonatomic,strong)NSArray  *dataA1;
@property(nonatomic,strong)NSArray  *dataA2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    JDDropView *drop_v=[[JDDropView alloc]initWithFrame:CGRectMake(0, 50, WIDTH, 50)];
//    drop_v.backgroundColor=[UIColor greenColor];
    drop_v.dataSource=self;
    drop_v.delegate=self;
    _dataA1=@[@{@"name":@"西乐",@"title":@[@"钢",@"钢琴",@"钢琴",@"钢琴",@"钢琴"]},@{@"name":@"国乐",@"title":@[@"琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴"]},@{@"name":@"外乐",@"title":@[@"机",@"钢琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴"]},@{@"name":@"就乐",@"title":@[@"去琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴",@"钢琴"]}];
    
    _dataA2=@[@"yu",@"yi",@"yo",@"tp",@"ji"];

    [self.view addSubview:drop_v];
    
    
    
    MYLABEL( label, 0, HEIGHT-100, WIDTH, 50, @"我们都是搬砖工", NSTextAlignmentCenter, 14, [UIColor blueColor], 0, self.view)
//    label.textAlignment=NSTextAlignmentCenter
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSString *)titleForLeftInColum:(int)colum InCellIndexPath:(int)index
{
    if (colum==0) {
        return _dataA1[index][@"name"];
    }
    
    return @"";
}
-(NSInteger)LeftTableViewCount:(int)colum
{
    if (colum==0) {
        return _dataA1.count;
    }
    return 2;
}
-(NSInteger)RightTableViewCount:(int)colum WithLeftIndex:(int)leftRow
{
    if (colum==0) {
        return ((NSArray *)_dataA1[leftRow][@"title"]).count;
    }
    if (colum==1) {
        return _dataA2.count;
    }
    return 0;
    
}
-(NSString *)titleForRightInColum:(int)colum WithLeftIndex:(int)leftRow InCellIndexPath:(int)index
{
    if (colum==0) {
        return [(NSArray *)_dataA1[leftRow][@"title"] objectAtIndex:index];
    }
    if (colum==1) {
        return _dataA2[index];
    }
    return @"";
}
-(NSInteger)numberOfMenuInMenu:(JDDropView *)dropV
{
    return 3;
    
}
-(NSInteger)dropViewTypeInColum:(int)colum InMenu:(JDDropView *)dropV
{
    if (colum==0) {
        return 2;
    }
    if (colum==1) {
        return 1;
    }
    return 0;
}
-(void)didSelectRowInColum:(int)colum WithLeftRow:(int)leftRow WithRightRow:(int)rightRow
{
    NSLog(@"%d====%d===%d",colum,leftRow,rightRow);
}
-(void)didSelectItemsTagArray:(NSArray *)itemsA
{
    NSLog(@"%@",itemsA);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
