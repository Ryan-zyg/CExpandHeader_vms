//
//  CustomHeadViewController.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-28.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import "CustomHeadViewController.h"
#import "CExpandHeader.h"

@interface CustomHeadViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end

@implementation CustomHeadViewController{
    CExpandHeader *_header;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.navigationBarHidden=YES;
	
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
//	[imageView setImage:[UIImage imageNamed:@"image"]];
	[imageView setImage:[UIImage imageNamed:@"22.jpg"]];
	
    //关键步骤 设置可变化背景view属性
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [customView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [label setText:@"这是一个自定义头部view"];
    [label setTextColor:[UIColor redColor]];
    [customView addSubview:label];
    
    _header = [CExpandHeader expandWithScrollView:_tableVIew expandView:customView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 99;
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


@end
