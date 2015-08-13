//
//  ViewController.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-27.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import "ViewController.h"
#import "CExpandHeader.h"

#define CExpandContentOffset @"contentOffset"

#define AFTER(s) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(s * NSEC_PER_SEC)), dispatch_get_main_queue(), ^

#define KNeedSaveOffset NO//YES//

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController{
    CExpandHeader *_header;
    __weak IBOutlet UITableView *_tableView;
	__weak UIImageView *_expandView;
	
	UIView* _headBg;
	UIView* _headView;
	UIView *_sectionView;
	
	int index;
	UITableView* _tableView1;
	UITableView* _tableView2;
	UIView* lineView;
	CGPoint tableOffset1;
	CGPoint tableOffset2;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.navigationBarHidden=YES;
	
	// build image view, add it below table view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
//	[imageView setImage:[UIImage imageNamed:@"image"]];
	[imageView setImage:[UIImage imageNamed:@"22.jpg"]];
	
	// build section view
	_sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
	_sectionView.backgroundColor=[UIColor lightGrayColor];
	
	[self.view addSubview:imageView];
//	_headBg=imageView;
//	_headBg.contentMode= UIViewContentModeScaleAspectFill;
//	_headBg.clipsToBounds = YES;
	
	// build transparent head view with custom info
	_headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
	_headView.backgroundColor=[UIColor clearColor];
	
	UILabel* lab=[[UILabel alloc] initWithFrame:_headView.bounds];
	lab.text=@"my info";
	lab.textAlignment=NSTextAlignmentCenter;
	lab.backgroundColor=[UIColor clearColor];
	[_headView addSubview:lab];
	
//	[_tableView addObserver:self forKeyPath:CExpandContentOffset options:NSKeyValueObservingOptionNew context:nil];
	_tableView.backgroundColor=[UIColor clearColor];
	[self.view bringSubviewToFront:_tableView];
	
	// add to listen observer to control imageView change with table scroll
    _header = [CExpandHeader expandWithScrollView:_tableView expandView:imageView];
	
	// build 2 sub table view
	_tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	_tableView1.delegate=self;
	_tableView1.dataSource=self;
	
	_tableView2=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	_tableView2.delegate=self;
	_tableView2.dataSource=self;
	
	// build tabbar 2 btn
	UIButton* btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame=CGRectMake(0, 0, _sectionView.frame.size.width/2, _sectionView.frame.size.height);
	[btn setTitle:@"table1" forState:UIControlStateNormal];
	[btn addTarget:self	action:@selector(changeToTable1) forControlEvents:UIControlEventTouchUpInside];
	[_sectionView addSubview:btn];
	
	btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame=CGRectMake(_sectionView.frame.size.width/2, 0, _sectionView.frame.size.width/2, _sectionView.frame.size.height);
	[btn setTitle:@"table2" forState:UIControlStateNormal];
	[btn addTarget:self	action:@selector(changeToTable2) forControlEvents:UIControlEventTouchUpInside];
	[_sectionView addSubview:btn];
	
	lineView=[[UIView alloc] initWithFrame:CGRectMake(0, _sectionView.frame.size.height-2, _sectionView.frame.size.width/2, 2)];
	lineView.backgroundColor=[UIColor redColor];
	[_sectionView addSubview:lineView];
	
	// set table height
	_tableView1.frame=CGRectMake(0, 0, 320, 44*20);
	_tableView2.frame=CGRectMake(0, 0, 320, 44*20);
	_tableView1.scrollEnabled=NO;
	_tableView2.scrollEnabled=NO;
	_tableView.contentSize=CGSizeMake(320, _tableView1.frame.size.height+40); // todo
}

-(void) changeToTable1
{
	NSLog(@"changeToTable1");
	if(index==0)
		return;
	
	tableOffset2=_tableView.contentOffset;
	
	[UIView beginAnimations:@"move" context:nil];
	[UIView setAnimationDuration:0.2];
	lineView.frame=CGRectMake(0, _sectionView.frame.size.height-2, _sectionView.frame.size.width/2, 2);
	[UIView commitAnimations];
	
	AFTER(0.2)
	{
		index=0;
		[_tableView reloadData];
		
		if(KNeedSaveOffset)
			_tableView.contentOffset=tableOffset1;
	});
}

-(void) changeToTable2
{
	NSLog(@"changeToTable2");
	if(index==2)
		return;
	
	tableOffset1=_tableView.contentOffset;
	
	[UIView beginAnimations:@"move" context:nil];
	[UIView setAnimationDuration:0.2];
	lineView.frame=CGRectMake(_sectionView.frame.size.width/2, _sectionView.frame.size.height-2, _sectionView.frame.size.width/2, 2);
	[UIView commitAnimations];
	
	AFTER(0.2)
	{
		index=2;
		[_tableView reloadData];
		
		if(KNeedSaveOffset)
			_tableView.contentOffset=tableOffset2;
	});
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if(tableView==_tableView)
	{
		if(section==0)
			return 0;
		
		return 1; // return table1 or table2
	}
	else if(tableView==_tableView1 || tableView==_tableView2)
	{
		return 20;
	}
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell=nil;
	if(tableView==_tableView1 || tableView==_tableView2)
	{
		cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
		if (!cell)
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

		cell.textLabel.textColor=(tableView==_tableView1 ? [UIColor redColor] : [UIColor blackColor]);
		[cell.textLabel setText:[NSString  stringWithFormat:@"this is row : %ld",(long)indexPath.row]];
	}
	else if(tableView==_tableView)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
		if(index==0)
			[cell.contentView addSubview:_tableView1];
		else
			[cell.contentView addSubview:_tableView2];
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if(tableView==_tableView)
		return _tableView1.frame.size.height;
	
    return 44.f;
}

// for add a section
-(CGFloat) tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	if(tableView==_tableView)
	{
		if(section==0)
			return _headView.frame.size.height;
		
		return _sectionView.frame.size.height;
	}
	
	return 0;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
	if(tableView==_tableView)
		return 2;
	
	return 1;
}

-(UIView*) tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
	if(tableView==_tableView)
	{
		if(section==0)
			return _headView;
		
		return _sectionView;
	}
	
	return nil;
}

@end
