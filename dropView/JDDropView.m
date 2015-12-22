//
//  JDDropView.m
//  dropView
//
//  Created by 刘洋 on 15/12/21.
//  Copyright © 2015年 刘洋. All rights reserved.
//

#import "JDDropView.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

#define menuHeight  50
#define rowHeight   45
#define rowNum      7
#define leftScale   0.3

@interface JDDropView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,assign)int currentMenuBtnIndex;
@property(nonatomic,assign)int currentLeftIndex;
@property(nonatomic,assign)int currentBtnTag;

@property(nonatomic,assign)int rememberLeft;
@property(nonatomic,assign)int rememberRight;
@property(nonatomic,assign)int rememberCenter;

@property(nonatomic,strong)UIButton *wayLastBTn;
@property(nonatomic,strong)UIButton *listenLastBTn;
@property(nonatomic,strong)UIButton *sexLastBTn;
@property(nonatomic,strong)UIButton *priceLastBTn;
@end
@implementation JDDropView

-(id)initWithFrame:(CGRect)frame;
{
    self=[super initWithFrame:frame ];
    if (self) {
        

        
        MYTABLEVIEW_(_leftTableView, 0, menuHeight, 0, 0, UITableViewStylePlain, [UIColor yellowColor], [UIColor yellowColor], self);
        MYTABLEVIEW_(_rightTableView, 0, menuHeight, 0, 0, UITableViewStylePlain, [UIColor purpleColor], [UIColor purpleColor], self);
        MYVIEW_(_noneView, 0, menuHeight, 0, 0, [UIColor blueColor], self)
      
        MYVIEW_(_bgView, 0, menuHeight, WIDTH, 0, [UIColor redColor], self)

        self.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.6];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.delegate=self;
        [self addGestureRecognizer:tap];
        
        
        [self initNoneView];
        _noneView.hidden=YES;
        _currentLeftIndex=0;

       
    }
    return self;
    
}

-(void)initNoneView
{
    NSArray *nameA=@[@"上课方式",@"不限",@"老师上门",@"学生上门",@"免费试听",@"不限",@"支持",@"",@"性别",@"不限",@"男",@"女",@"价格范围",@"不限",@"100~200",@"200~300",@"300~400",@"400~600",@"600~800",@">800"];
    for (int i=0; i<20; i++) {
        int X=i%4;
        int Y=i/4;
        MYBUTTON(button, WIDTH*0.25*X, rowHeight*Y, WIDTH*0.25, rowHeight, [UIColor darkGrayColor], nameA[i], @selector(buttonClick:), [UIColor whiteColor], i,14, [UIColor purpleColor], nil, _noneView);
        
        if (button.tag==0||button.tag==4||button.tag==7||button.tag==8||button.tag==12) {
            [button setEnabled:NO];
        }
        if (button.tag==1) {
            _wayLastBTn=button;
            button.selected=YES;
        }
        if (button.tag==5) {
            _listenLastBTn=button;
            button.selected=YES;
        }
        if (button.tag==9) {
            _sexLastBTn=button;
            button.selected=YES;
        }
        if (button.tag==13) {
            _priceLastBTn=button;
            button.selected=YES;
        }
        
    }
    
    
    MYBUTTON(button, 0, rowHeight*5, WIDTH, rowHeight, [UIColor whiteColor],@"确定", @selector(sureClick), [UIColor greenColor], 0,14, [UIColor whiteColor], nil, _noneView);
   
}
-(void)setDataSource:(id<DropViewDataSource>)dataSource
{
    _dataSource=dataSource;
    
    if ([_dataSource respondsToSelector:@selector(numberOfMenuInMenu:)]) {
        _numberOfMenu=[_dataSource numberOfMenuInMenu:self];
    }else
    {
        _numberOfMenu=1;
    }
    
    for (int i=0;i<_numberOfMenu; i++) {
        MYBUTTON(menuBtn,WIDTH/_numberOfMenu*i, 0, WIDTH/_numberOfMenu, menuHeight, [UIColor redColor], @"hahh", @selector(menuBtnClick:), [UIColor grayColor], i,15, nil, nil, self)
        
        
    }
    
}
-(void)sureClick
{
    _lastBtn.selected=NO;
    [self animationUp:_currentMenuBtnIndex];
    
    NSMutableArray * itemsA = [[NSMutableArray alloc]initWithCapacity:0];
    for (id view in _noneView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)view;
            if (btn.selected) {
                NSLog(@"%ld",(long)btn.tag);
                [itemsA addObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
            }
        }
    }
    [self.delegate didSelectItemsTagArray:itemsA];
    
    
}
-(void)buttonClick:(UIButton *)button
{
    
    if (button.tag>0&&button.tag<4) {
        if (_wayLastBTn==button) {
            
        }else
        {
            _wayLastBTn.selected=NO;
            button.selected=YES;
            _wayLastBTn=button;
        }
    }
    if (button.tag>4&&button.tag<8) {
        if (_listenLastBTn==button) {
            
        }else
        {
            _listenLastBTn.selected=NO;
            button.selected=YES;
            _listenLastBTn=button;
        }
    }
    if (button.tag>8&&button.tag<12) {
        if (_sexLastBTn==button) {
            
        }else
        {
            _sexLastBTn.selected=NO;
            button.selected=YES;
            _sexLastBTn=button;
        }
    }
    if (button.tag>12) {
        if (_priceLastBTn==button) {
            
        }else
        {
            _priceLastBTn.selected=NO;
            button.selected=YES;
            _priceLastBTn=button;
        }
    }
    
}
#pragma mark gestureRecognizer
-(void)tapClick:(UIGestureRecognizer *)tap
{
    _lastBtn.selected=NO;
    [self animationUp:_currentMenuBtnIndex];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint  point  =[gestureRecognizer locationInView:self];
    
    CGRect  rectLeft=_leftTableView.frame;
    CGRect  rectRight=_rightTableView.frame;
    CGRect  rectNone=_noneView.frame;
    
    BOOL isIN1=CGRectContainsPoint(rectLeft, point);
    BOOL isIN2=CGRectContainsPoint(rectRight, point);
    BOOL isIN3=CGRectContainsPoint(rectNone, point);
    
    if (isIN1||isIN2||isIN3) {
        return NO;
        
    }
    return YES;
    
}
#pragma mark MenuBtnClick
-(void)menuBtnClick:(UIButton *)button
{
    _currentBtnTag=(int)button.tag;
    
    NSInteger tapIndex = 0;
    if ([self.dataSource respondsToSelector:@selector(dropViewTypeInColum:InMenu:)]) {
        tapIndex=[self.dataSource dropViewTypeInColum:(int)button.tag InMenu:self];
    }
    
    _currentMenuBtnIndex=(int)tapIndex;
   
    if (button.selected) {
        [self animationUp:(int)tapIndex];
        button.selected=NO;
        
    }else
    {
        [self animationDown:(int)tapIndex];
        button.selected=YES;
    }
    
    if (!_lastBtn) {
        _lastBtn=button;
    }else
    {
        if (_lastBtn==button) {
            
        }else
        {
            _lastBtn.selected=NO;

        }
        _lastBtn=button;
        [_leftTableView reloadData];
        [_rightTableView reloadData];
    }
    
    
}
#pragma mark animation
-(void)animationUp:(int)tapIndex
{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame=CGRectMake(0, self.frame.origin.y, WIDTH, menuHeight);
        switch (tapIndex) {
            case 0:
                _noneView.hidden=YES;
                _noneView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
                break;
            case 1:
                _leftTableView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
                _rightTableView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
                break;
            case 2:
                _leftTableView.frame=CGRectMake(0, menuHeight, WIDTH*leftScale, 0);
                _rightTableView.frame=CGRectMake(WIDTH*leftScale, menuHeight, WIDTH*(1-leftScale), 0);
                
                break;
                
            default:
                break;
        }

    }];
    
}
-(void)animationDown:(int)tapIndex
{
    
    switch (tapIndex) {
        case 0:
            _noneView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
            _leftTableView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
            _rightTableView.frame=CGRectMake(WIDTH*leftScale, menuHeight, WIDTH*(1-leftScale), 0);
            
            break;
        case 1:
            _noneView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
            _leftTableView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
            _rightTableView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
            
            break;
        case 2:
            _noneView.frame=CGRectMake(0, menuHeight, WIDTH, 0);
            _leftTableView.frame=CGRectMake(0, menuHeight, WIDTH*leftScale, 0);
            _rightTableView.frame=CGRectMake(WIDTH*leftScale, menuHeight, WIDTH*(1-leftScale), 0);
            
            break;
            
        default:
            break;
    }
    int count=(int)[self.dataSource RightTableViewCount:_currentBtnTag WithLeftIndex:_currentLeftIndex];
    NSLog(@"--%d",count);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, self.frame.origin.y, WIDTH, HEIGHT);
        switch (tapIndex) {
            case 0:
                _noneView.hidden=NO;
                _noneView.frame=CGRectMake(0, menuHeight, WIDTH, 270);
                break;
            case 1:
                _noneView.hidden=YES;
                _rightTableView.frame=CGRectMake(0, menuHeight, WIDTH, rowHeight*count<rowHeight*rowNum?rowHeight*count:rowHeight*rowNum);
                
                break;
            case 2:
                _noneView.hidden=YES;
                _leftTableView.frame=CGRectMake(0, menuHeight, WIDTH*leftScale, rowHeight*count<rowHeight*rowNum?rowHeight*count:rowHeight*rowNum);
                _rightTableView.frame=CGRectMake(WIDTH*leftScale, menuHeight, WIDTH*(1-leftScale), rowHeight*count<rowHeight*rowNum?rowHeight*count:rowHeight*rowNum);
                
                break;
                
            default:
                break;
        }
        
        
    }];

    
}

#pragma mark TableViewDelegate AND TableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTableView) {
        return [self.dataSource LeftTableViewCount:(int)_lastBtn.tag];
    }
    if (tableView==_rightTableView) {
        return [self.dataSource RightTableViewCount:(int)_lastBtn.tag WithLeftIndex:_currentLeftIndex];
    }
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    
    if (tableView==_leftTableView) {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[self.dataSource titleForLeftInColum:0 InCellIndexPath:(int)indexPath.row]];
        if (_currentBtnTag==0) {
            if (_rememberLeft==indexPath.row) {
                cell.textLabel.textColor=[UIColor purpleColor];
            }
        }
        
    }
    if (tableView==_rightTableView) {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[self.dataSource titleForRightInColum:(int)_lastBtn.tag WithLeftIndex:_currentLeftIndex InCellIndexPath:(int)indexPath.row]];

        if (_currentBtnTag==0) {
            if (_rememberRight==indexPath.row) {
                cell.textLabel.textColor=[UIColor purpleColor];
            }
        }
        if (_currentBtnTag==1) {
            if (_rememberCenter==indexPath.row) {
                cell.textLabel.textColor=[UIColor purpleColor];
            }
        }
    }
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTableView) {
        _currentLeftIndex = (int)indexPath.row;
        _rememberLeft=(int)indexPath.row;
        
        for (int i=0; i<[tableView numberOfRowsInSection:0]; i++) {
            NSIndexPath *path=[NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:path];
            cell.textLabel.textColor=[UIColor darkGrayColor];
        }
        
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor=[UIColor purpleColor];
        [_rightTableView reloadData];
        
    }
    if (tableView==_rightTableView) {
        for (int i=0; i<[tableView numberOfRowsInSection:0]; i++) {
            NSIndexPath *path=[NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:path];
            cell.textLabel.textColor=[UIColor darkGrayColor];
        }
        
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor=[UIColor purpleColor];
        
        _lastBtn.selected=NO;
        [self animationUp:_currentMenuBtnIndex];
        
        if (_currentBtnTag==0) {
            _rememberRight=(int)indexPath.row;
        }else
        {
            _rememberCenter=(int)indexPath.row;
        }
        
        [self.delegate didSelectRowInColum:_currentBtnTag WithLeftRow:_currentLeftIndex WithRightRow:(int)indexPath.row];

        
    }
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [_lastBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
   
}
@end
