# dropView
a list


    _data1=@{@"title":@"name",@"data":@[@"id"]};
    _data2 = [NSMutableArray arrayWithObjects:@"智能排序", @"离我最近", @"教龄最高", @"价格从高到低", @"价格从低到高", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"筛选", nil];
    
    
    JDDropView *dropV=[[JDDropView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 40)];
    dropV.delegate=self;
    dropV.dataSource=self;
    [self.view addSubview:dropV];
