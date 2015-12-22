//
//  commonDefine.h
//  xueyuanpai
//
//  Created by 刘洋 on 15/12/18.
//  Copyright © 2015年 hao. All rights reserved.
//

#ifndef commonDefine_h
#define commonDefine_h


#define  HORIZONTAL_LINE(grayView,x,y,color,super_view)   UIView *grayView=[[UIView alloc]initWithFrame:CGRectMake(x, y, JDScreenWidthCurOri, 1)];grayView.backgroundColor=color;[super_view addSubview:grayView];

#define MYLABEL(label,X,Y,WIDTH,HEIGHT,text_s,NST,fontSize,color,numberOfLs,super_view)  UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(X, Y, WIDTH, HEIGHT)];label.text=text_s;label.textAlignment=NST;label.font=[UIFont systemFontOfSize:fontSize];label.textColor=color;label.numberOfLines=numberOfLs;[super_view addSubview:label];

#define MYLABEL_(label,X,Y,WIDTH,HEIGHT,text_s,NST,fontSize,color,numberOfLs,super_view)  label=[[UILabel alloc]initWithFrame:CGRectMake(X, Y, WIDTH, HEIGHT)];label.text=text_s;label.textAlignment=NST;label.font=[UIFont systemFontOfSize:fontSize];label.textColor=color;label.numberOfLines=numberOfLs;[super_view addSubview:label];

#define MYBUTTON(button,X,Y,WIDTH,HEIGHT,normalColor,title,selector,BGCOLOR,TAG,size,title_selColor,selTitle,super_view)  UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];button.frame=CGRectMake(X, Y, WIDTH, HEIGHT);[button setTitleColor:normalColor forState:UIControlStateNormal];[button setTitle:title forState:UIControlStateNormal];[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];button.backgroundColor=BGCOLOR;button.tag=TAG;button.titleLabel.font=[UIFont systemFontOfSize:size];[button setTitleColor:title_selColor forState:UIControlStateSelected];[button setTitle:selTitle forState:UIControlStateSelected];[super_view addSubview:button];

#define MYBUTTON_(button,X,Y,WIDTH,HEIGHT,normalColor,title,selector,BGCOLOR,TAG,title_selColor,selTitle,super_view)  button=[UIButton  buttonWithType:UIButtonTypeCustom];button.frame=CGRectMake(X, Y, WIDTH, HEIGHT);[button setTitleColor:normalColor forState:UIControlStateNormal];[button setTitle:title forState:UIControlStateNormal];[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];button.backgroundColor=BGCOLOR;button.tag=TAG;[button setTitleColor:title_selColor forState:UIControlStateSelected];[button setTitle:selTitle forState:UIControlStateSelected];[super_view addSubview:button];

#define MYTABLEVIEW_(tableview,X,Y,WIDTH,HEIGHT,TableViewStyle,bgColor,sepColor,super_view)   tableview=[[UITableView alloc]initWithFrame:CGRectMake(X,Y,WIDTH,HEIGHT) style:UITableViewStylePlain];tableview.delegate=self;tableview.dataSource=self;tableview.backgroundColor=bgColor;tableview.separatorColor=sepColor;[super_view addSubview:tableview];

#define MYVIEW(view,X,Y,WIDTH,HEIGHT,bgColor,super_view)   UIView *view=[[UIView alloc]initWithFrame:CGRectMake(X,Y,WIDTH,HEIGHT)];view.backgroundColor=bgColor;[super_view addSubview:view];

#define MYVIEW_(view,X,Y,WIDTH,HEIGHT,bgColor,super_view)   view=[[UIView alloc]initWithFrame:CGRectMake(X,Y,WIDTH,HEIGHT)];view.backgroundColor=bgColor;[super_view addSubview:view];


#define PUSHVC(JDAboutMeViewController)   JDAboutMeViewController *aboutMeVC = [[JDAboutMeViewController alloc]init];[self.navigationController pushViewController:aboutMeVC animated:YES];

#define POPVC  [self.navigationController popViewControllerAnimated:YES];



#endif /* commonDefine_h */
