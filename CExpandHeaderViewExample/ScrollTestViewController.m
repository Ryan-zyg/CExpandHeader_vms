//
//  ScrollTestViewController.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-28.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import "ScrollTestViewController.h"
#import "CExpandHeader.h"
@interface ScrollTestViewController ()

@end

@implementation ScrollTestViewController{
    
    __weak IBOutlet UIScrollView *scrollView;
	CExpandHeader *_header;
	UITableView* _tableView;
	UIView *_sectionView;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.navigationBarHidden=YES;
	
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
//	[imageView setImage:[UIImage imageNamed:@"image"]];
	[imageView setImage:[UIImage imageNamed:@"22.jpg"]];
	
    [scrollView setContentSize:CGSizeMake(0, 480)];
    _header = [CExpandHeader expandWithScrollView:scrollView expandView:imageView];
	
	_sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, 30)];
	_sectionView.backgroundColor=[UIColor redColor];
	
	float y=imageView.frame.size.height;
	_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, 480-y)];
	[scrollView addSubview:_tableView];
	
	_tableView.delegate=self;
	_tableView.dataSource=self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	[cell.textLabel setText:[NSString  stringWithFormat:@"this is row :%ld",(long)indexPath.row]];
	return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44.f;
}

// for add a section
//-(CGFloat) tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
//{
//	return 30;
//}
//
//-(NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
//{
//	return 1;
//}
//
//-(UIView*) tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
//{
//	return _sectionView;
//}

@end
