//
//  JDDropView.h
//  dropView
//
//  Created by 刘洋 on 15/12/21.
//  Copyright © 2015年 刘洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDDropView;
@protocol DropViewDataSource <NSObject>

@required
-(NSInteger)numberOfMenuInMenu:(JDDropView *)dropV;
-(NSInteger)dropViewTypeInColum:(int)colum InMenu:(JDDropView *)dropV;
-(NSInteger)LeftTableViewCount:(int)colum;
-(NSInteger)RightTableViewCount:(int)colum WithLeftIndex:(int)leftRow;
-(NSString *)titleForLeftInColum:(int)colum InCellIndexPath:(int)index;
-(NSString *)titleForRightInColum:(int)colum WithLeftIndex:(int)leftRow InCellIndexPath:(int)index;
@end

@protocol DropViewDelegate <NSObject>
-(void)didSelectRowInColum:(int)colum WithLeftRow:(int)leftRow WithRightRow:(int)rightRow;
-(void)didSelectItemsTagArray:(NSArray *)itemsA;

@end
@interface JDDropView : UIView
-(id)initWithFrame:(CGRect)frame;
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *rightTableView;
@property(nonatomic,strong)UIView      *bgView;
@property(nonatomic,strong)UIView      *noneView;
@property(nonatomic,strong)UIButton    *lastBtn;

@property(nonatomic,weak)id <DropViewDelegate>      delegate;
@property(nonatomic,weak)id <DropViewDataSource>    dataSource;


@property(nonatomic,assign)NSInteger numberOfMenu;
@end
