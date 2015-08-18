//
//  ScrollTestViewController.h
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-28.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollTestViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
	float beginY;
	float scrollViewBeginY;
	float tableViewBeginY;
}

-(BOOL) checkCanScroll;
-(void) updateScroll:(float)y;
-(UITableView*) tableView;

@end
