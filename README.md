Create dropView


    _data1=@{@"title":@"name",@"data":@[@"id"]};
    _data2 = [NSMutableArray arrayWithObjects:@"智能排序", @"离我最近", @"教龄最高", @"价格从高到低", @"价格从低到高", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"筛选", nil];
    
    
    JDDropView *dropV=[[JDDropView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 40)];
    dropV.delegate=self;
    dropV.dataSource=self;
    [self.view addSubview:dropV];









DropViewDataSourceAndDelegate



-(NSInteger)numberOfMenuInMenu:(JDDropView *)dropV
{

    return 3;
}

-(NSInteger)dropViewTypeInColum:(int)colum InMenu:(JDDropView *)dropV
{

    //2,1,0表示样式（0表示noview，1表示一个tableview，2表示两个tableview）
   
    return 0;
}

-(NSInteger)LeftTableViewCount:(int)colum
{

    //左边的tableView行数
    return 0;
}

-(NSInteger)RightTableViewCount:(int)colum WithLeftIndex:(int)leftRow
{

    //点击左边右边的tableView行数
    return 0;
}

-(NSString *)titleForLeftInColum:(int)colum InCellIndexPath:(int)index
{


    return @"";
}

-(NSString *)titleForRightInColum:(int)colum WithLeftIndex:(int)leftRow InCellIndexPath:(int)index
{

    return @"";
}

//delegate

-(void)didSelectRowInColum:(int)colum WithLeftRow:(int)leftRow WithRightRow:(int)rightRow
{

    
}

-(void)didSelectItemsTagArray:(NSArray *)itemsA
{

   
    
}
