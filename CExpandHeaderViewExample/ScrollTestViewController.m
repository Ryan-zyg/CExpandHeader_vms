//
//  ScrollTestViewController.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-28.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import "ScrollTestViewController.h"
#import "CExpandHeader.h"
#import "GUITableView.h"
#import "GUIScrollView.h"
#import "GDefine.h"


@implementation ScrollTestViewController{
    
//    __weak IBOutlet UIScrollView* scrollView;
	GUIScrollView* scrollView;
	
	CExpandHeader* header;
	UIView* bgView;
	UIView* tabbarView;
	UIView* navBar;
	
	UIView* lineView;
	int index;
	
	GUITableView* tableView1;
	GUITableView* tableView2;
}

-(void) viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.navigationBarHidden=YES;
	
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
//	[imageView setImage:[UIImage imageNamed:@"image"]];
	[imageView setImage:[UIImage imageNamed:@"22.jpg"]];
	[self.view addSubview:imageView];
	bgView=imageView;
	
	// build scroll view
	scrollView=[[GUIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	scrollView.delegate=self;
	[self.view addSubview:scrollView];
	
	[scrollView setContentSize:CGSizeMake(0, 480+180)];
	scrollView.backgroundColor=[UIColor clearColor];
    header = [CExpandHeader expandWithScrollView:scrollView expandView:bgView];
	header.parentControl=self;
	header.limitHeight=bgView.frame.size.height-64;
	
	// build nav bar
	navBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
	navBar.backgroundColor=[UIColor lightGrayColor];
	[self.view addSubview:navBar];
	navBar.alpha=0;
	
	// build info
	UILabel* lab=[[UILabel alloc] initWithFrame:bgView.frame];
	lab.text=@"my info";
	lab.textAlignment=NSTextAlignmentCenter;
	lab.backgroundColor=[UIColor clearColor];
	[scrollView addSubview:lab];
	
	// build tabbar view
	tabbarView=[[UIView alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height, self.view.frame.size.width, 40)];
	tabbarView.backgroundColor=[UIColor grayColor];
	[scrollView addSubview:tabbarView];
	
	// build tabbar 2 btn
	UIButton* btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame=CGRectMake(0, 0, tabbarView.frame.size.width/2, tabbarView.frame.size.height);
	[btn setTitle:@"table1" forState:UIControlStateNormal];
	[btn addTarget:self	action:@selector(changeToTable1) forControlEvents:UIControlEventTouchUpInside];
	[tabbarView addSubview:btn];
	
	btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame=CGRectMake(tabbarView.frame.size.width/2, 0, tabbarView.frame.size.width/2, tabbarView.frame.size.height);
	[btn setTitle:@"table2" forState:UIControlStateNormal];
	[btn addTarget:self	action:@selector(changeToTable2) forControlEvents:UIControlEventTouchUpInside];
	[tabbarView addSubview:btn];
	
	lineView=[[UIView alloc] initWithFrame:CGRectMake(0, tabbarView.frame.size.height-2, tabbarView.frame.size.width/2, 2)];
	lineView.backgroundColor=[UIColor redColor];
	[tabbarView addSubview:lineView];
	
	// build 2 sub table view
	float y=tabbarView.frame.origin.y+tabbarView.frame.size.height;
	tableView1=[[GUITableView alloc] initWithFrame:CGRectMake(0, y, 320, scrollView.frame.size.height-64-tabbarView.frame.size.height)];
	tableView1.delegate=self;
	tableView1.dataSource=self;
	tableView1.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
	tableView1.parentControl=self;
//	tableView1.bounces=NO;
	
	tableView2=[[GUITableView alloc] initWithFrame:tableView1.frame];
	tableView2.delegate=self;
	tableView2.dataSource=self;
	tableView1.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
	tableView2.parentControl=self;
//	tableView2.bounces=NO;
	
	[scrollView addSubview:tableView1];
	[scrollView addSubview:tableView2];
	tableView2.hidden=YES;
	
//	tableView1.scrollEnabled=NO;
//	tableView2.scrollEnabled=NO;
//	scrollView.scrollEnabled=YES;
	
	tableView1.passTouchEvent=YES;
	tableView2.passTouchEvent=YES;
	scrollView.passTouchEvent=NO;
}

// return YES is allow scrollView to scroll, or only allow table view to scroll
-(BOOL) checkCanScroll
{
	if(scrollView.contentOffset.y==header.limitHeight)
		return YES;
	
//	[header updateOffset:offset];
	return NO;
}

-(void) updateScroll:(float)y // 40 - header.limitHeight
{
	navBar.alpha=(y-40)/(header.limitHeight-40);
	
	if(scrollView.contentOffset.y==header.limitHeight)
	{
//		[[self tableView] becomeFirstResponder];
//		[scrollView resignFirstResponder];
		
//		tableView1.scrollEnabled=YES;
//		tableView2.scrollEnabled=YES;
//		scrollView.scrollEnabled=NO;
		
		tableView1.passTouchEvent=NO;
		tableView2.passTouchEvent=NO;
		scrollView.passTouchEvent=YES;
	}
	else
	{
//		[scrollView becomeFirstResponder];
//		[[self tableView] resignFirstResponder];
		
//		tableView1.scrollEnabled=NO;
//		tableView2.scrollEnabled=NO;
//		scrollView.scrollEnabled=YES;
		
		tableView1.passTouchEvent=YES;
		tableView2.passTouchEvent=YES;
		scrollView.passTouchEvent=NO;
	}
}

-(void) changeToTable1
{
	NSLog(@"changeToTable1");
	if(index==0)
		return;
	
	[UIView beginAnimations:@"move" context:nil];
	[UIView setAnimationDuration:0.2];
	lineView.frame=CGRectMake(0, tabbarView.frame.size.height-2, tabbarView.frame.size.width/2, 2);
	[UIView commitAnimations];
	
	AFTER(0.2)
	{
		index=0;
		tableView1.hidden=NO;
		tableView2.hidden=YES;
	});
}

-(void) changeToTable2
{
	NSLog(@"changeToTable2");
	if(index==2)
		return;
	
	[UIView beginAnimations:@"move" context:nil];
	[UIView setAnimationDuration:0.2];
	lineView.frame=CGRectMake(tabbarView.frame.size.width/2, tabbarView.frame.size.height-2, tabbarView.frame.size.width/2, 2);
	[UIView commitAnimations];
	
	AFTER(0.2)
	{
		index=2;
		tableView1.hidden=YES;
		tableView2.hidden=NO;
	});
}

-(UITableView*) tableView
{
	return (index==0 ? tableView1 : tableView2);
}

-(void) scrollViewWillBeginDragging2:(UIScrollView*)scrollView_
{
	beginY=scrollView_.contentOffset.y;
	scrollViewBeginY=scrollView.contentOffset.y;
	tableViewBeginY=[self tableView].contentOffset.y;
}

-(void) scrollViewDidScroll2:(UIScrollView*)scrollView_
{
	if(scrollView.contentOffset.y==header.limitHeight)
	{
		tableView1.scrollEnabled=YES;
		tableView2.scrollEnabled=YES;
		scrollView.scrollEnabled=NO;
	}
	else
	{
		tableView1.scrollEnabled=NO;
		tableView2.scrollEnabled=NO;
		scrollView.scrollEnabled=YES;
	}
	return;
	
	float offset=scrollView_.contentOffset.y-beginY;
	if(scrollView_==scrollView)
	{
		if(scrollView.contentOffset.y==header.limitHeight)
		{
			LOGA(@"0");
			[self tableView].contentOffset=CGPointMake(0, 0);
		}
		else
		{
			LOGA(@"1");
		}
	}
	else
	{
		if(scrollView.contentOffset.y!=header.limitHeight)
		{
			LOGA(@"2");
			[self tableView].contentOffset=CGPointMake(0, 0);
			scrollView.contentOffset=CGPointMake(0, scrollView.contentOffset.y+offset);
		}
		else if(scrollView_.contentOffset.y<=0)
		{
			LOGA(@"3");
			[self tableView].contentOffset=CGPointMake(0, 0);
			scrollView.contentOffset=CGPointMake(0, scrollView.contentOffset.y+offset);
		}
		else
		{
			CGFloat height=[self tableView].frame.size.height;
			CGFloat distanceFromBottom=height-[self tableView].contentOffset.y;
			
			if(distanceFromBottom<=height) // end of table
			{
				LOGA(@"end of table");
			}
			else
			{
				LOGA(@"4");
				[self tableView].contentOffset=CGPointMake(0, [self tableView].contentOffset.y+offset);
			}
		}
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell=nil;
	if(tableView==tableView1 || tableView==tableView2)
	{
		cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
		if (!cell)
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
		
		cell.textLabel.textColor=(tableView==tableView1 ? [UIColor redColor] : [UIColor blackColor]);
		[cell.textLabel setText:[NSString  stringWithFormat:@"this is row : %ld",(long)indexPath.row]];
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 44.f;
}

@end
